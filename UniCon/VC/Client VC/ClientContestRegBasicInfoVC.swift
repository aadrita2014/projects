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
    let formatter = DateFormatter()
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
    @IBAction func backClicked() {
        dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func nextPageAction(_ sender: UIButton) {
     
       
        if (eventPeriodStartBtn.titleLabel!.text)! != "" && (eventPeriodEndBtn.titleLabel!.text)! != "" && (reviewPeriodStartBtn.titleLabel!.text)! != "" && (reviewPeriodEndBtn.titleLabel!.text)! != "" && (dateOfAnnouncementBtn.titleLabel!.text)! != "" && contactNameTf.text! != "" && contactNo.text! != ""{
        createContestregRequest.startTime = (eventPeriodStartBtn.titleLabel!.text)!
        createContestregRequest.endTime = (eventPeriodEndBtn.titleLabel!.text)!
        createContestregRequest.examinationStartTime =  (reviewPeriodStartBtn.titleLabel!.text)!
        createContestregRequest.examinationEndTime = (reviewPeriodEndBtn.titleLabel!.text)!
        createContestregRequest.publicationTime =  (dateOfAnnouncementBtn.titleLabel!.text)!
        createContestregRequest.contactName = contactNameTf.text!
        createContestregRequest.contactPhone = contactNo.text!
         self.performSegue(withIdentifier: "ClientContestRegDetailsViewController", sender: nil)
        }
        else {
             self.showAlertMessage(message: "Please Enter all fields")
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
        print("datePicker.date",datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: datePicker.date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "YYYY-MM-dd"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)

        print("hiulkd dayte",myStringafd)
        selectedBtn?.titleLabel?.text = myStringafd
        selectedBtn?.setTitle(myStringafd, for: UIControl.State.normal)
        print("mass data bala",eventPeriodStartBtn?.titleLabel?.text)
        togglePicker(show: false)
    }
}
