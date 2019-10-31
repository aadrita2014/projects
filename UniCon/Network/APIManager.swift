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
    static func authenticate(username:String, password:String,role:String) -> Promise<UserResponseModel> {
        let request = TokenRequest(username: username, password: password, role: role)
//        return TokenManager.requestToken(request: request)
        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]
        return POST(URL:APIRouter.LOGIN, parameters: parameters)
    }
    static func registerNewUser(param:[String:Any]) -> Promise<RegisterResponseModel> {
        return POST(URL:APIRouter.REGISTER, parameters: param)
    }
}
