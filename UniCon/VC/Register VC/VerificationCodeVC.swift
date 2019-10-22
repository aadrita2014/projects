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
    @IBOutlet weak var verificationCodeTf: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var regModel:TempRegModel? = nil
    //MARK: View Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add Default Background Color to the view
        self.view.addBlackBackgroundColor()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        viewSetup()
    }
    func viewSetup() {
        verificationCodeTf.addBottomBorder(color: AppColors.default_red_color)
        verificationCodeTf.updatePlaceHolder(text: "000000")
        verificationCodeTf.inputAccessoryView = bottomToolbar
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
            register()
        }
    }
    //MARK: Validations
    func validate() -> String? {
        if verificationCodeTf.text?.isEmpty == true {
            return ValidationError.empty.rawValue
        }
        return nil
    }
    //MARK: API Call
    func register() {
        if let model = regModel {
            self.showLoading()
            let modelParam = model.toDictionary() as! [String:AnyObject]
            AuthenticationManager.register(param: modelParam).done { (request) in
                print(request)
                self.hideLoading()
            }.catch { (error) in
                print(error)
                self.showAlertMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func showPrivacyPolicy() {
        self.performSegue(withIdentifier: "PrivacyPolicy", sender: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    

}
