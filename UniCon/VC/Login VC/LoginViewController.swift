//
//  ViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
class LoginViewController: UIViewController {

    //MARK: IBOutlets Declared
    @IBOutlet weak var emailButton:UIButton!
    @IBOutlet weak var kakaoButton:UIButton!
    @IBOutlet weak var facebookButton:UIButton!
    @IBOutlet weak var googleButton:UIButton!
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var signupButton:UIButton!
    
    //MARK: View Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        
        //Underline the buttons
        loginButton.underline()
        signupButton.underline()
        
        
        AF.upload(multipartFormData: { formdata in
            formdata.append(Data("asdasd@gmail.com".utf8), withName: "email")
            formdata.append(Data("1234567".utf8), withName: "password")
            formdata.append(Data("asdfgh".utf8), withName: "name")
            formdata.append(Data("asdfgh".utf8), withName: "nickName")
            formdata.append(Data("creator".utf8), withName: "role")
            formdata.append(Data("1234567890".utf8), withName: "phoneNumber")
        }, to: APIRouter.LOGIN).responseJSON { (response) in
            print(response)
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //Aspect Fit the image on the buttons
        emailButton.imageView?.contentMode = .scaleAspectFit
        kakaoButton.imageView?.contentMode = .scaleAspectFit
        facebookButton.imageView?.contentMode = .scaleAspectFit
        googleButton.imageView?.contentMode = .scaleAspectFit
        
        
        
    }
    //MARK: IBActions Defined
    @IBAction func emailLoginClicked()
    {
        //TODO: Add Email Login Functionality
        print("Email Login Clicked")
    }

    @IBAction func kakaoLoginClicked()
    {
        //TODO: Add Kakao Login Functionality
        print("Kakao Login Clicked")
    }
    
    @IBAction func facebookLoginClicked()
    {
        //TODO: Add Facebook Login Functionality
        print("Facebook Login Clicked")
    }
    @IBAction func googleLoginClicked()
    {
        //TODO: Add Google Login Functionality
        print("Google Login Clicked")
    }
    
    
}


