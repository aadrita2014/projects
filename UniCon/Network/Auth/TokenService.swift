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
    
    enum TokenCodingKeys : String, CodingKey{
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
        case expiresIn = "expiresIn"
        case tokenType = "tokenType"
    }
    
    static func instance(dictionary: NSDictionary) -> Token{
        let token = Token(dictionary: dictionary)
        return token
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TokenCodingKeys.self)
        accessToken = try (container.decodeIfPresent(String.self, forKey: .accessToken) ?? "")
        refreshToken = try (container.decodeIfPresent(String.self, forKey: .refreshToken) ?? "")
        expiresIn = try (container.decodeIfPresent(String.self, forKey: .expiresIn) ?? "")
        tokenType = try (container.decodeIfPresent(String.self, forKey: .tokenType) ?? "")
    }
    
    override required init() {
    }
    
    func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: TokenCodingKeys.self)
        try container.encodeIfPresent(accessToken, forKey: .accessToken)
        try container.encodeIfPresent(refreshToken, forKey: .refreshToken)
        try container.encodeIfPresent(expiresIn, forKey: .expiresIn)
        try container.encodeIfPresent(tokenType, forKey: .tokenType)
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
        return POST(url:APIRouter.LOGIN, request: request)
    }
//    static func refreshToken (request: TokenRefresh) -> Promise<Token> {
//        return POST(url:APIRouter.REFRESH_TOKEN, request: request) }

    // MARK: - POST
    private static func POST<T:EVReflectable>(url:String, request: T) -> Promise<UserResponseModel>
    {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : Any]
        return POST(URL: url, parameters: parameters,headers: headers, encoding: URLEncoding.default)
    }
}
