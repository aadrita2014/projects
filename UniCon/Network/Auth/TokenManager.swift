//
//  TokenManager.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
//import EVReflection


//MARK: TokenManager to refresh & request tokens
struct TokenManager {
    private static var userDefaults = UserDefaults.standard
    private static var tokenKey = "token_key_defaults_user"
    private static var userModelKey = "user_model_key_defaults"
    private static var expiringKey = "expiring_date"
    static var date = Date()
    
    static var token:Token?
    {
        guard let tokenDict = userDefaults.dictionary(forKey: tokenKey) else { return nil }
        let token = Token.instance(dictionary: tokenDict as NSDictionary)
        return token
    }
    
    static var tokenExist: Bool { return token != nil }
    
    static var tokenIsValid: Bool {
        if let expiringDate = userDefaults.value(forKey: expiringKey) as? Date {
            if date >= expiringDate {
                return false
            } else {
                return true
            }
        }
        return true
    }
    static var loggedInUser:User? {
        guard let userDict = userDefaults.dictionary(forKey: userModelKey) else { return nil }
        let userModel = User.instance(dictionary: userDict as NSDictionary)
        return userModel
    }
    static func requestToken(request: TokenRequest) -> Promise<Void> {
        return Promise { resolve in
            TokenService.requestToken(request: request).done { (model) in
                save(userResModel: model)
//                setToken(token: model.token)
                resolve.fulfill(())
            }.catch { (error) in
                resolve.reject(error)
            }
        }
    }
    
    //        static func refreshToken() -> Promise<Void>
    //        {
    //            return Promise { resolve in
    //
    //                guard let token = token else { return }
    //
    //                let request = TokenRefresh(refreshToken: token.refreshToken)
    //
    //                TokenService.refreshToken(request: request).done { (token) in
    //                    setToken(token: token)
    //                    resolve.fulfill()
    //                }.catch { error in
    //                    resolve.reject(error)
    //                }
    //            }
    //        }
    
    private static func setToken (token:Token!) {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .month, value: 1, to: today)
        userDefaults.setValue(tomorrow, forKey: expiringKey)
        userDefaults.setValue(token.toDictionary(), forKey: tokenKey)
    }
    static func save(userResModel:UserResponseModel) {
        setToken(token: userResModel.token)
        userDefaults.setValue(userResModel.user.toDictionary(), forKey: userModelKey)
    }
    static func deleteToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    static func logoutUser() {
        deleteToken()
        userDefaults.removeObject(forKey: userModelKey)
    }
}

