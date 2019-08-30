//
//  ClientContestRegBasicInfoVC.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ClientContestRegBasicInfoVC: UIViewController {

    
    @IBOutlet var bgView: [UIView]!
    @IBOutlet var dateBtns: [UIButton]!
    
    //MARK: IBOutlets
    @IBOutlet weak var eventPeriodStartBtn: UIButton!
    @IBOutlet weak var eventPeriodEndBtn: UIButton!
    @IBOutlet weak var reviewPeriodStartBtn: UIButton!
    @IBOutlet weak var reviewPeriodEndBtn: UIButton!
    @IBOutlet weak var dateOfAnnouncementBtn: UIButton!
    
    @IBOutlet weak var contactNameTf: UITextField!
    @IBOutlet weak var contactNo: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerToolbar: UIToolbar!
    
    var selectedBtn:UIButton? = nil
    
    //MARK: Overriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add default black background color to the view
        self.view.addBlackBackgroundColor()
        
        //Other view setup
        setupView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupView() {
        
        //Background view setup
        for view in bgView {
            view.addDarkGrayBackgroundColor()
            view.addCornerRadius()
        }
        
        //Buttons setup
        eventPeriodStartBtn.addCornerRadius()
        eventPeriodEndBtn.addCornerRadius()
        reviewPeriodStartBtn.addCornerRadius()
        reviewPeriodEndBtn.addCornerRadius()
        dateOfAnnouncementBtn.addCornerRadius()
        
        //Textfields setup
        contactNameTf.updatePlaceHolder(text: "김OO", color: UIColor.white)
        contactNo.updatePlaceHolder(text: "000-0000-0000", color: UIColor.white)
        contactNameTf.addBottomBorder(color: AppColors.default_red_color)
        contactNo.addBottomBorder(color: AppColors.default_red_color)
        
        
        //Picker view setup
        datePicker.addDarkGrayBackgroundColor()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.isHidden = true
        pickerToolbar.isHidden = true
    }
    func removeBordersFromButtons(){
        eventPeriodStartBtn.addBorderColor(borderWidth: 0, color: UIColor.clear)
        eventPeriodEndBtn.addBorderColor(borderWidth: 0, color: UIColor.clear)
        reviewPeriodStartBtn.addBorderColor(borderWidth: 0, color: UIColor.clear)
        reviewPeriodEndBtn.addBorderColor(borderWidth: 0, color: UIColor.clear)
        dateOfAnnouncementBtn.addBorderColor(borderWidth: 0, color: UIColor.clear)
    }
    //MARK: Picker View Methods
    func togglePicker(show: Bool) {
        datePicker.isHidden = !show
        pickerToolbar.isHidden = !show
    }
    //MARK: IBAction Methods
    @IBAction func changeDatePressed(_ sender: UIButton) {
        removeBordersFromButtons()
        sender.addBorderColor(borderWidth: 2.0, color: AppColors.default_red_color)
        selectedBtn = sender
        togglePicker(show: true)
    }
    
    @IBAction func moveToNextButton() {
        for (index,btn) in dateBtns.enumerated() {
            if btn == selectedBtn! {
                if dateBtns.count > index + 1 {
                    changeDatePressed(dateBtns[index+1])
                }
                else {
                    togglePicker(show: false)
                }
                
                break
            }
        }
    }
    
    @IBAction func moveToPrevButton() {
        
        for (index,btn) in dateBtns.enumerated() {
            if btn == selectedBtn! {
                if index > 0 {
                    changeDatePressed(dateBtns[index-1])
                }
                else {
                    togglePicker(show: false)
                }
                break
            }
        }
    }
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        togglePicker(show: false)
    }
}
