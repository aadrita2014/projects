//
//  ClientRegistrationConfirmationVC.swift
//  UniCon
//
//  Created by Ricky on 8/31/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ClientRegistrationConfirmationVC: UIViewController {
let authenticationService = AuthenticationService()
    @IBOutlet var mainScrollView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
     
    @IBAction func nextButtonAction(_ sender: UIButton) {
         self.showLoading()
        authenticationService.contestCreateApi(contestCreate: createContestregRequest) { model,error in
            DispatchQueue.main.async {
                   //                          self.hideLoading()
                                             if let error = error {
                                                 self.showAlertMessage(message: error)
                                             }
                                             else {
                                                 self.hideLoading()
//                                                print("model",model!["contest"])
                                                self.performSegue(withIdentifier: "ContestRegistrationDepositInfoVC", sender: nil)
                                             }
            }
        }
                          
               
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add black background color
        viewSetup()
        
        
        
    }
    override func viewWillLayoutSubviews() {
         self.scrollView.contentSize = CGSize(width: view.bounds.width, height: 680)
    }
    func viewSetup() {
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: 680)
        self.view.addBlackBackgroundColor()
    }
}
