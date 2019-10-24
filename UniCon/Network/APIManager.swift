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
import Alamofire


struct AuthenticationService:NetworkService {
    
//    static func authenticate(username:String, password:String,role:String) -> Promise<Void> {
//        let request = TokenRequest(username: username, password: password, role: role)
//        return TokenManager.requestToken(request: request)
//    }
    static func registerNewUser(param:[String:Any]) -> Promise<UserResponseModel> {
        return POST(URL:APIRouter.REGISTER, parameters: param)
    }
}
