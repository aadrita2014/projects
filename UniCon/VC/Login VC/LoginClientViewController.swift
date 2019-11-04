//
//  LoginClientViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit

class LoginClientViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlets Declared
    @IBOutlet weak var emailTf:UITextField!
    @IBOutlet weak var passwordTf:UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
    }
    override func viewDidAppear(_ animated: Bool) {
        //Add Bottom Border for Textfields
        emailTf.addBottomBorder(color: UIColor.red)
        passwordTf.addBottomBorder(color: UIColor.red)
        
        //Add gray placeholder color for better visibility
        emailTf.updatePlaceHolder(text: "aaa@bbb.ccc")
        passwordTf.updatePlaceHolder(text: "*******")
        
        //Register for keyboard notifications
        registerNotifications()
        
        //Tap to dismiss the keyboard
        tapToDismiss()
    }
    //MARK: IBActions Defined
    @IBAction func loginClicked() {
        //TODO: Login Functionality
       // Defaults.saveBool(key: StringConsts.isClientSaveKey, value: true) //Temp. to be removed after API implementation
//        self.performSegue(withIdentifier: "Home", sender: nil)
        login()
    }
    @IBAction func forgotPasswordClicked() {
        //TODO: Forgot Password Functionality Required
        print("Forgot Password Clicked")
    }
    @IBAction func creatorLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: API Call
        func login() {
            //Show Loading
            self.showLoading()
            firstly {
                //Authenticate with the API
                AuthenticationService.authenticate(username: self.emailTf.text!, password: self.passwordTf.text!,role: Role.client.rawValue)
            }.done { (_) in
                //If successful
    //            print("Logged In Successfully")
    //            TokenManager.save(userResModel: userModel)
                Defaults.saveBool(key: StringConsts.isClientSaveKey, value: true)
                self.hideLoading()
                self.performSegue(withIdentifier: "Home", sender: nil)
                
            }
            .catch { (error) in
                //If generates error
                self.hideLoading()
                self.showAlertMessage(title: ValidationError.defaultErrorTitle.rawValue, message: error.localizedDescription)
            }
        }
        
    //Text Field Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //If Enter/Next is pressed on the email text
        if textField == emailTf {
            //Move to next textfield
            passwordTf.becomeFirstResponder()
        }
        else {
            //hide the keyboard and call the login function
            hideKeyboard()
            loginClicked()
        }
        return false
    }
    //MARK: Scrollview adjust code when keyboard shows/hides
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    func tapToDismiss() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginClientViewController.hideKeyboard))
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        scrollView.contentInset.bottom = 0
    }
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    //MARK: Deinitialisations
    deinit {
        unregisterNotifications()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

