//
//  VerificationCodeVC.swift
//  UniCon
//
//  Created by Ricky on 10/21/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
class VerificationCodeVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var emailLabel:UILabel!
    @IBOutlet weak var verificationCodeTf: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var email:String?
  
    //MARK: View Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addBlackBackgroundColor()
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      //  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        viewSetup()
    }
    func viewSetup() {
      
        verificationCodeTf.addBottomBorder(color: AppColors.default_red_color)
        verificationCodeTf.updatePlaceHolder(text: "000000")
        verificationCodeTf.inputAccessoryView = bottomToolbar
        verificationCodeTf.becomeFirstResponder()
        
        if let email = self.email {
            emailLabel.text = "\(email) 으로 전송된 인증번호를 입력하세요."
        }
        else {
            emailLabel.text = ""
        }
        // verificationCodeTf.becomeFirstResponder()
    }
    
    //MARK: IBActions
    @IBAction func backClicked() {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func nextClicked(_ sender: Any) {
        if let errMsg = validate() {
            showAlertMessage(title: ValidationError.defaultErrorTitle.rawValue, message: errMsg)
        }
        else {
            self.moveToHome()
        }
    }
    //MARK: Validations
    func validate() -> String? {
        if verificationCodeTf.text?.isEmpty == true {
            return ValidationError.empty.rawValue
        }
        return nil
    }
    func showPrivacyPolicy() {
        self.performSegue(withIdentifier: "PrivacyPolicy", sender: nil)
    }
}


extension VerificationCodeVC {
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
