//
//  MemberInfoViewController.swift
//  UniCon
//
//  Created by Ricky on 10/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MemberInfoViewController: UIViewController {

    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPassTf: UITextField!
    
    var regModel:TempRegModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup default black background color
        self.view.addBlackBackgroundColor()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillLayoutSubviews() {
        //view setup
        viewSetup()
    }
    func viewSetup() {
        //username field setup
        usernameTf.addBottomBorder(color: AppColors.default_red_color)
        usernameTf.updatePlaceHolder(text: "고릴랄라")
        usernameTf.becomeFirstResponder()
        
        //password field setup
        passwordTf.addBottomBorder(color: AppColors.default_red_color)
        passwordTf.updatePlaceHolder(text: "********")
        
        //confirm password field setup
        confirmPassTf.addBottomBorder(color: AppColors.default_red_color)
        confirmPassTf.updatePlaceHolder(text: "********")
    }
    
    @IBAction func nextClicked() {
        if let errMsg = validate() {
            showAlertMessage(title: ValidationError.defaultErrorTitle.rawValue, message: errMsg)
        }
        else {
            if regModel != nil {
                regModel?.username = usernameTf.text!
                regModel?.password = passwordTf.text!
                 moveToVerificationCode(model: regModel!)
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
    
}
