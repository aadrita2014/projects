//
//  MemberInfoViewController.swift
//  UniCon
//
//  Created by Ricky on 10/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
class MemberInfoViewController: UIViewController {
    
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPassTf: UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var containerView:UIView!
    
    
    var regModel:TempRegModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup default black background color
        self.view.addBlackBackgroundColor()
        
        //        print("Model Info \(regModel)")
        // Do any additional setup after loading the view.
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        //view setup
        viewSetup()
    }
    func viewSetup() {
        //username field setup
        usernameTf.addBottomBorder(color: AppColors.default_red_color)
        usernameTf.updatePlaceHolder(text: "고릴랄라")
        //usernameTf.becomeFirstResponder()
        
        //password field setup
        passwordTf.addBottomBorder(color: AppColors.default_red_color)
        passwordTf.updatePlaceHolder(text: "********")
        
        //confirm password field setup
        confirmPassTf.addBottomBorder(color: AppColors.default_red_color)
        confirmPassTf.updatePlaceHolder(text: "********")
        
        //registe for keyboard notifications
        registerNotifications()
        
        //add tap to dismiss to the scroll view
        tapToDismiss()
    }
    
    @IBAction func nextClicked() {
        if let errMsg = validate() {
            showAlertMessage(title: ValidationError.defaultErrorTitle.rawValue, message: errMsg)
        }
        else {
            if regModel != nil {
                regModel?.name = usernameTf.text!
                regModel?.password = passwordTf.text!
                register()
                //moveToVerificationCode(model: regModel!)
            }
            else {
                showAlertMessage(title: "Error", message: "Please go back and enter your email")
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    //MARK: Validations
    func validate() -> String? {
        
        return nil
    }
    
    //MARK: API Call
    func register() {
        if let model = regModel {
            // self.showLoading()
            let modelParam = model.toDictionary() as! [String:AnyObject]
            // print(modelParam)
            self.showLoading()
            firstly {
                //Authenticate with the API
                AuthenticationService.registerNewUser(param: modelParam)
            }.done { (model) in
                //If successful
                self.hideLoading()
            }
            .catch {
                //If generates error
                if let error = $0 as? NetworkError {
                    self.hideLoading()
                    self.showAlertMessage(message: "\(error.localizedDescription)")
                }
            }
        }
    }
    //MARK: Navigation
    func moveToVerificationCode(model:TempRegModel) {
        self.performSegue(withIdentifier: "VerificationCode", sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VerificationCodeVC {
            let vc = segue.destination as! VerificationCodeVC
            vc.regModel = sender as? TempRegModel
        }
    }
    //MARK: Deinitialisations
    deinit {
        unregisterNotifications()
    }
}

extension MemberInfoViewController {
    
    //MARK: Scrollview adjust code when keyboard shows/hides
    @objc func hideKeyboard()
    {
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
    
    
    
    
}

