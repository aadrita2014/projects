//
//  ViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //IBOutlets Declared
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var signupButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        
        //Underline the buttons
        loginButton.underline()
        signupButton.underline()
        
    }
    @IBAction func emailLoginClicked()
    {
        print("Email Login Clicked")
    }

    @IBAction func kakaoLoginClicked()
    {
        print("Kakao Login Clicked")
    }
    
    @IBAction func facebookLoginClicked()
    {
        print("Facebook Login Clicked")
    }
    @IBAction func googleLoginClicked()
    {
        print("Google Login Clicked")
    }
}

