//
//  MemberInfoViewController.swift
//  UniCon
//
//  Created by Ricky on 10/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
class MemberInfoVC: UIViewController {
    
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPassTf: UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var containerView:UIView!
    
    var regRequest:RegistrationRequest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup default black background color
        self.view.addBlackBackgroundColor()
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
    @IBAction func backClicked()  {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextClicked() {
        if let errMsg = validate() {
            showAlertMessage(message: errMsg)
        }
        else {
            if regRequest != nil {
                regRequest?.name = usernameTf.text!
                regRequest?.password = passwordTf.text!
                regRequest?.nickName = usernameTf.text!
                regRequest?.phoneNumber = "0000000000"
                regRequest?.role = Role.creator.role
                register()
            }
            else {
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
        if let request = regRequest {
            let modelParam = request.toDictionary() as! [String:String]
            self.showLoading()
            self.moveToVerificationCode()
//            firstly {
                //Authenticate with the API
                AuthenticationService.registerNewUser(params: modelParam,completion: { model,error in
                    self.hideLoading()
                    if let error = error {
                        self.showAlertMessage(message: error)
                    }
                    else {
                        if let userResModel = UserResponseModel.instance(token: model!.token, user: model!.user) {
                            TokenManager.save(userResModel: userResModel)
                            self.moveToVerificationCode()
                        }
                        else {
                            self.showAlertMessage(message: "Registration Failed")
                        }
                    }
                })
//            }.done { (model) in
//                //If successful
//                if AppConsts.DEBUG_MODE {
//                    print("Successfully Registered")
//                }
//                if let userResModel = UserResponseModel.instance(token: model.token, user: model.user) {
//                    TokenManager.save(userResModel: userResModel)
//                    self.hideLoading()
//                    //self.performSegue(withIdentifier: "Home", sender: nil)
//                }
//                else {
//                    self.showAlertMessage(message: "Registration Failed")
//                }
//            }
//            .catch {
//                //If generates error
//                self.hideLoading()
//                if let error = $0 as? NetworkError {
//                    self.showAlertMessage(message: "\(error.localizedDescription)")
//                }
//            }
        }
    }
    //MARK: Navigation
    func moveToVerificationCode() {
        self.performSegue(withIdentifier: "VerificationCode", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VerificationCodeVC {
            let vc = segue.destination as! VerificationCodeVC
            vc.email = regRequest?.email
//            vc.regModel = sender as? RegistrationRequest
        }
    }
    //MARK: Deinitialisations
    deinit {
        unregisterNotifications()
    }
}

extension MemberInfoVC{
    
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

