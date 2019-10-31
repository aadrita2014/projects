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

class Token: EVObject, Codable{
    
    var accessToken:String = ""
    var refreshToken:String = ""
    var expiresIn:String = ""
    var tokenType:String = ""
    
    static func instance(dictionary: NSDictionary) -> Token{
        let token = Token(dictionary: dictionary)
        return token
    }
    required init() {
        
    }
}
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
        
    }
}
class TokenRefresh:EVObject {
    var email:String = ""
    var refreshToken:String = ""
    
    init(refreshToken:String) {
        self.refreshToken = refreshToken
    }
    required init() {
        
    }
}
struct TokenService: NetworkService
{
    static func requestToken (request: TokenRequest) -> Promise<UserResponseModel> {
        return POST(url:APIRouter.LOGIN, request: request) }
//    static func refreshToken (request: TokenRefresh) -> Promise<Token> {
//        return POST(url:APIRouter.REFRESH_TOKEN, request: request) }

    // MARK: - POST
    private static func POST<T:EVReflectable>(url:String, request: T) -> Promise<UserResponseModel>
    {
       // let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]
        return POST(URL: url, parameters: parameters, encoding: URLEncoding.default)
    }
}
