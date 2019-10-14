//
//  AuthenticationManager.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import EVReflection

 class RegisterRequest: EVObject {
    var email = ""
    var password = ""
    var businessRegisterCertificate = ""
    var name = ""
    var nickName = ""
    var role = ""
    var phoneNumber = ""
    var facebook = ""
    var google = ""
    var talk = ""
    var kakao = ""
    var companyName = ""
    var businessRegistrationNumber = ""
    var representativeName = ""

    required init() {
        fatalError("init() has not been implemented")
    }
    
}
struct AuthenticationManager
{
    static func authenticate(username:String, password:String,role:String) -> Promise<Void>
    {
        let request = TokenRequest(username: username, password: password, role: role)
        return TokenManager.requestToken(request: request)
    }
    static func register(param:[String:AnyObject]) -> Promise<RegisterRequest>{
        return AuthorizationService.POST(URL: APIRouter.REGISTER, parameters: param)
    }
    
}


//MARK: Registration Params Helper

//    email    String
//    User's email
//
//    password    String
//    User's password
//
//    Size range: 6..128
//
//    businessRegistrationCertificate    File
//    User's Business Registartion Certificate (only for clients)
//
//    name    String
//    User's Name
//
//    Size range: 6..128
//
//    nickName    String
//    User's nickanme
//
//    Size range: 5..128
//
//    role    String
//    User's role (client, creator or admin)
//
//    phoneNumber    String
//    User's email
//
//      facebook    String
//    User's facebook auth token
//
//      google    String
//    User's google auth token
//
//      talk    String
//    User's talk auth token
//
//      kakao    String
//    User's kakao auth token
//
//    companyName    String
//    User's Company Name (Only for client)
//
//    businessRegistrationNumber    String
//    User's Business Registration Number(Only for client)
//
//    representativeName
