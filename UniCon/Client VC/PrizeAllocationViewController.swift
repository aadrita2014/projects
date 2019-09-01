//
//  PrizeAllocationViewController.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class PrizeAllocationViewController: UIViewController {

    //MARK: IBOutlets
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
        
        //Add default background color to the view
        self.view.addBlackBackgroundColor()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        //Other view setup
        viewSetup()
    }
    //MARK: View Setup
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
    //text field helper
    func filterTextField(tf:UITextField) -> String {
        if let tfText = tf.text {
            //Remove spaces
            let text = tfText.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            return text
        }
        return ""
    }
}

extension PrizeAllocationViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        calculatePrizeAmount()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
