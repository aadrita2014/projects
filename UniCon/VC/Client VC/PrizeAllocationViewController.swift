//
//  PrizeAllocationViewController.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
var createContestregRequest = CreateContestRequest()
class PrizeAllocationViewController: UIViewController,MyDataSendingDelegateProtocol {

    //MARK: IBOutlets
    @IBOutlet var prize3Percentage: UILabel!
    @IBOutlet var prize1Percentage: UILabel!
    @IBOutlet var prize2Percentage: UILabel!
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var changePrizeBtn: UIButton!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var priceTf: UITextField!
    @IBOutlet weak var prize1stLabel: UILabel!
    @IBOutlet weak var prize2ndLabel: UILabel!
    @IBOutlet weak var prize3rdLabel: UILabel!
    @IBOutlet weak var platformFeeLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var prizeDistributionArr = [50,30,20]
    let platformFee = 25.0
    let currency = "원" //For demo purposes otherwise system local currency will be used
    //MARK: Overriden view code
    override func viewDidLoad() {
        super.viewDidLoad()
        prize1Percentage.text = String(prizeDistributionArr[0]) + "%"
        prize2Percentage.text = String(prizeDistributionArr[1]) + "%"
        prize3Percentage.text = String(prizeDistributionArr[2]) + "%"
        //Add default background color to the view
        self.view.addBlackBackgroundColor()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        //Other view setup
        viewSetup()
    }
    //MARK: View Setup
    func sendDataToFirstViewController(myData: [Int]) {
          prizeDistributionArr = myData
        prize1Percentage.text = String(prizeDistributionArr[0]) + "%"
    prize2Percentage.text = String(prizeDistributionArr[1]) + "%"
        prize3Percentage.text = String(prizeDistributionArr[2]) + "%"
        calculatePrizeAmount()
       }
    func viewSetup() {
        
        //Background view setup
        topBackgroundView.addCornerRadius(radius: 10)
        topBackgroundView.addDarkGrayBackgroundColor()
        
        bottomBackgroundView.addCornerRadius(radius: 10)
        bottomBackgroundView.addDarkGrayBackgroundColor()
        
        //Buttons Setup
        nextBtn.addCornerRadius() 
        learnMoreButton.underline()
        changePrizeBtn.addCornerRadius(radius: 2)
        
        //Textfield Setup
        priceTf.addBottomBorder(color: AppColors.default_red_color)
        priceTf.updatePlaceHolder(text: "5,000,000", color: UIColor.darkGray)
        
    }
    
    //MARK: IBActions
    @IBAction func changePrizeClicked(){
        self.performSegue(withIdentifier: "ChangePrize", sender: nil)
    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
     guard let priceAmout = priceTf.text else {
                        return
                    }
        
        if priceAmout != "" {
       var prize1stString =  prize1Percentage.text!
            prize1stString = String(prize1stString.dropLast())
            prize1stString = prize1stString.replacingOccurrences(of: ",", with: "")
            var prize2ndString = prize2Percentage.text!
            prize2ndString = String(prize2ndString.dropLast())
            prize2ndString = prize2ndString.replacingOccurrences(of: ",", with: "")
            var prize3rdString = prize3Percentage.text!
            prize3rdString = String(prize3rdString.dropLast())
             prize3rdString = prize3rdString.replacingOccurrences(of: ",", with: "")
            var totalAmountString = totalAmountLabel.text!
            totalAmountString = String(totalAmountString.dropLast())
            totalAmountString = totalAmountString.replacingOccurrences(of: ",", with: "")
            var platformFeeString = platformFeeLabel.text!
            platformFeeString = String(platformFeeString.dropLast())
            platformFeeString = platformFeeString.replacingOccurrences(of: ",", with: "")
        createContestregRequest.first = prize1stString
        createContestregRequest.second =  prize2ndString
        createContestregRequest.third = prize3rdString
        createContestregRequest.totalPrize = totalAmountString
        createContestregRequest.platformFee = platformFeeString

        self.performSegue(withIdentifier: "ClientContestRegBasicInfoVC", sender: nil)
        }
        else {
            self.showAlertMessage(message: "Please Enter Prize Allocation Amount")
        }
        
    }
    
    //MARK: Keyboard handle code
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Hide keyboard when clicked anywhere
        self.view.endEditing(true)
    }
    
    //MARK: Prize Calculation
    func calculatePrizeAmount() {
        
        if let doubleEnteredPrize = Double(filterTextField(tf: priceTf)), prizeDistributionArr.count > 2 {
            
            let firstPrizePercent = Double(prizeDistributionArr[0])
            let secondPrizePercent = Double(prizeDistributionArr[1])
            let thirdPrizePercent = Double(prizeDistributionArr[2])
            
            let firstPrizeAmount =  doubleEnteredPrize * (firstPrizePercent/100.0)
            let secondPrizeAmount = doubleEnteredPrize * (secondPrizePercent/100.0)
            let thirdPrizeAmount = doubleEnteredPrize * (thirdPrizePercent/100.0)
            let platformAmount = doubleEnteredPrize * (platformFee/100.0)
            let totalAmount = firstPrizeAmount + secondPrizeAmount + thirdPrizeAmount + platformAmount
            
            
            let firstPrizeStr = StringHelpers.convertToPriceStr(fromVal: firstPrizeAmount)
            let secondPrizeStr = StringHelpers.convertToPriceStr(fromVal: secondPrizeAmount)
            let thirdPrizeStr = StringHelpers.convertToPriceStr(fromVal: thirdPrizeAmount)
            let platformStr = StringHelpers.convertToPriceStr(fromVal: platformAmount)
            let totalStr = StringHelpers.convertToPriceStr(fromVal: totalAmount)
            
           // priceTf.text = StringHelpers.formatToNumberStr(val: doubleEnteredPrize)
            prize1stLabel.text = firstPrizeStr
            prize2ndLabel.text = secondPrizeStr
            prize3rdLabel.text = thirdPrizeStr
            platformFeeLabel.text = platformStr
            totalAmountLabel.text = totalStr
        
        }
    }
    //Text field helper
    func filterTextField(tf:UITextField) -> String {
        if let tfText = tf.text {
            //Remove spaces
            let text = tfText.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            return text
        }
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChangePrizeAllocationVC {
            vc.delegate = self
            vc.prizeDtributionArr = prizeDistributionArr
            vc.enteredAmount = StringHelpers.convertToPriceStr(fromVal: priceTf.text!)
        }
    }
}

extension PrizeAllocationViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //textField.text = StringHelpers.formatToNumberStr(val: textField.text!)
        calculatePrizeAmount()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
