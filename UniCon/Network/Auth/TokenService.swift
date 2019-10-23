//
//  TokenService.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import EVReflection
import Alamofire

class TokenRequest:EVObject {
    var email:String = ""
    var password:String = ""
    var role:String = ""
    
    init(username:String,password:String,role:String) {
        super.init()
        self.email = username
        self.password = password
        self.role = role
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
class TokenRefresh:EVObject {
    var email:String = ""
    var refreshToken:String = ""
    
    init(refreshToken:String) {
        self.refreshToken = refreshToken
    }
    required init() {
        fatalError("init() has not been implemented")
    }
}
struct TokenService: NetworkService
{
    static func requestToken (request: TokenRequest) -> Promise<Token> {
        return POST(url:APIRouter.LOGIN, request: request) }
    static func refreshToken (request: TokenRefresh) -> Promise<Token> {
        return POST(url:APIRouter.REFRESH_TOKEN, request: request) }
    
    // MARK: - POST
    private static func POST<T:EVReflectable>(url:String, request: T) -> Promise<Token>
    {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]
        return POST(URL: url, parameters: parameters, headers: headers, encoding: URLEncoding.default)
    }
}
