//
//  ChangePrizeAllocationVC.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

protocol PrizeAllocationDelegate {
    func setPriceAllocationPercentage(prizeDtributionArr : [Int])
}

class ChangePrizeAllocationVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var prize1Background: UIView!
    @IBOutlet weak var prize2Background: UIView!
    @IBOutlet weak var prize3Background: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var prize1Slider: UISlider!
    @IBOutlet weak var prize2Slider: UISlider!
    @IBOutlet weak var prize3Slider: UISlider!
    
    @IBOutlet weak var prize1Label: UILabel!
    @IBOutlet weak var prize2Label: UILabel!
    @IBOutlet weak var prize3Label: UILabel!
    
    @IBOutlet var prizeAmountLbl: [UILabel]!
    
    private var alertView:CustomAlertView? = nil
    var enteredAmount:String = "0"
    var prizeDtributionArr = [0,0,0]
    var delegate: PrizeAllocationDelegate!
    
    //MARK: Overriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Default black background color
        self.view.addBlackBackgroundColor()
        
        //Other view setup methods
        setupView()
    }
    func setupView() {
        
        //Background view setup
        topBackgroundView.addCornerRadius(radius: 10)
        prize1Background.addCornerRadius(radius: 10)
        prize2Background.addCornerRadius(radius: 10)
        prize3Background.addCornerRadius(radius: 10)
        
        topBackgroundView.addDarkGrayBackgroundColor()
        prize1Background.addDarkGrayBackgroundColor()
        prize2Background.addDarkGrayBackgroundColor()
        prize3Background.addDarkGrayBackgroundColor()
        
        //Buttons setup
        saveBtn.addCornerRadius()
        
        //Label setup
        enteredAmount = enteredAmount == "" ? "0" : enteredAmount
        totalAmountLabel.text = StringHelpers.convertToPriceStr(fromVal: enteredAmount)
        
        let doubleEnteredPrize = Double(enteredAmount) ?? 0
        prizeAmountLbl.forEach{
            $0.text = StringHelpers.convertToPriceStr(fromVal: doubleEnteredPrize * Double(prizeDtributionArr[$0.tag - 1])/100)
        }
        
    }
    //MARK: IBActions
    @IBAction func savePressed() {
        if checkForTotalPercentage() {
            delegate.setPriceAllocationPercentage(prizeDtributionArr: prizeDtributionArr)
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func backClicked() {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sliderChanged(_ sender:UISlider) {
        let intVal = Int(sender.value * 100.0)
        let str = "\(intVal)" + "%"
        if sender == prize1Slider {
            prize1Label.text = str
            prizeDtributionArr[0] = intVal
        }
        else if sender == prize2Slider {
            prize2Label.text = str
            prizeDtributionArr[1] = intVal
        }
        else if sender == prize3Slider {
            prize3Label.text = str
            prizeDtributionArr[2] = intVal
        }
        if let doubleEnteredPrize = Double(enteredAmount)  {
           prizeAmountLbl[sender.tag - 1].text =  StringHelpers.convertToPriceStr(fromVal: doubleEnteredPrize * Double(intVal)/100)
        }
    }

    func checkForTotalPercentage() -> Bool{
//        var totPercent = 0
//        for element in prizeDtributionArr {
//            totPercent = totPercent + element
//        }
        
        let totPercent = prizeDtributionArr.reduce(0) {$0 + $1}
        if totPercent != 100 {
            showErrorAlertView()
            return false
        }
        return true
    }
    //MARK: Custom Alert View
    func showErrorAlertView(){
        if alertView == nil {
            alertView = CustomAlertView(frame: self.view.frame , title: "상금 배분 오류", desc: "상금 배분의 총 합은 100%보다 \n작거나 클 수 없습니다.", btnTitle: "확인")
            alertView?.dismissClicked = {
                self.removeAlertView()
            }
            self.view.addSubview(alertView!)
        }
    }
    
    func removeAlertView() {
        if let view = alertView {
            view.removeFromSuperview()
            alertView = nil
        }
    }
    
    
    
}
