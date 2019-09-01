//
//  ChangePrizeAllocationVC.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ChangePrizeAllocationVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var prize1Background: UIView!
    @IBOutlet weak var prize2Background: UIView!
    @IBOutlet weak var prize3Background: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var alertView:CustomAlertView? = nil
    var enteredAmount:String = ""
    
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
        totalAmountLabel.text = enteredAmount
    }
    //MARK: IBActions
    @IBAction func savePressed() {
            showAlertView()
    }
    @IBAction func backClicked() {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertView(){
        
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
