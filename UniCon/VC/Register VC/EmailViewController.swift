//
//  EmailViewController.swift
//  UniCon
//
//  Created by Ricky on 10/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    //MARK: View Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add Default Background Color to the view
        self.view.addBlackBackgroundColor()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillLayoutSubviews() {
        viewSetup()
    }
    func viewSetup() {
        emailTf.addBottomBorder(color: AppColors.default_red_color)
        emailTf.updatePlaceHolder(text: "aaa@bbb.ccc")
        emailTf.inputAccessoryView = bottomToolbar
        emailTf.becomeFirstResponder()
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
            let regModel = TempRegModel()
            regModel.email = emailTf.text!
            moveToNextScreen(regModel)
        }
    }
    //MARK: Validations
    func validate() -> String? {
        if emailTf.text?.isEmpty == true {
            return ValidationError.empty.rawValue
        }
        return nil
    }
       
    //MARK: Navigation
    func moveToNextScreen(_ model:TempRegModel) {
        self.performSegue(withIdentifier: "MemberInfo", sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MemberInfoViewController {
            let vc = segue.destination as! MemberInfoViewController
            vc.regModel = sender as? TempRegModel
        }
    }
    
    
    
}
