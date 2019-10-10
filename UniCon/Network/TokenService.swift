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
    var username:String = ""
    var password:String = ""
    
    init(username:String,password:String) {
        super.init()
        self.username = username
        self.password = password
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
class TokenRefresh:EVObject {
    
}
struct TokenService: NetworkService
{
    static func requestToken (request: TokenRequest) -> Promise<Token> { return POST(request: request) }

    static func refreshToken (request: TokenRefresh) -> Promise<Token> { return POST(request: request) }

    // MARK: - POST

    private static func POST<T:EVReflectable>(request: T) -> Promise<Token>
    {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]

        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]

        return POST(URL: "", parameters: parameters, headers: headers, encoding: URLEncoding.default)
    }
}
