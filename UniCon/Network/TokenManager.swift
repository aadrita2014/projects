//
//  TokenManager.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import EVReflection

class Token: EVObject {
    
    var accessToken:String = ""
    
    static func instance(dictionary: NSDictionary) -> Token{
        let token = Token(dictionary: dictionary)
        return token
    }
}
struct TokenManager {
        private static var userDefaults = UserDefaults.standard
        private static var tokenKey = ""//CONSTANTS.userDefaults.tokenKey
        static var date = Date()

        static var token:Token?
        {
            guard let tokenDict = userDefaults.dictionary(forKey: tokenKey) else { return nil }

            let token = Token.instance(dictionary: tokenDict as NSDictionary)

            return token
        }

        static var tokenExist: Bool { return token != nil }

        static var tokenIsValid: Bool
        {
            if let expiringDate = userDefaults.value(forKey: "EXPIRING_DATE") as? Date
            {
                if date >= expiringDate
                {
                    return false
                }else{
                    return true
                }
            }
            return true
        }

        static func requestToken(request: TokenRequest) -> Promise<Void>?
        {
            return nil
//            return Promise { fulFill, reject in
//
//                TokenService.requestToken(request: request).then { (token: Token) -> Void in
//                    setToken(token: token)
//
//                    let today = Date()
//                    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
//                    userDefaults.setValue(tomorrow, forKey: "EXPIRING_DATE")
//
//                    fulFill()
//                }.catch { error in
//                    reject(error)
//                }
//            }
        }

        static func refreshToken() -> Promise<Void>?
        {
            return nil
//            return Promise.init(resolver: { fulFill, reject in
//
//                guard let token = token else { return }
//
//                let  request = TokenRefresh(refreshToken: token.refreshToken)
//
//                TokenService.refreshToken(request: request).then { (token: Token) -> Void in
//                    setToken(token: token)
//                    fulFill()
//                }.catch { error in
//                    reject(error)
//                }
//            })
        }

        private static func setToken (token:Token!)
        {
            userDefaults.setValue(token.toDictionary(), forKey: tokenKey)
        }

        static func deleteToken()
        {
            userDefaults.removeObject(forKey: tokenKey)
        }
    }

