//
//  AuthorizationService.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import EVReflection

struct AuthorizationService: NetworkService {
    
    private static var authorizedHeader:[String: String]
    {
        guard let accessToken = TokenManager.token?.accessToken else
        {
            return ["Authorization": ""]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - POST
    
//    static func POST<T:EVObject> (URL: String, parameters: [String: AnyObject], encoding: ParameterEncoding) -> Promise<T>
//    {
//        return firstly
//            {
//                return POST(URL: URL, parameters: parameters, headers: authorizedHeader, encoding: encoding)
//                
//        }.catch { error in
//
//            switch ((error as NSError).code)
//            {
//            case 401:
//                _ = TokenManager.refreshToken().then { return POST(URL: URL, parameters: parameters, encoding: encoding) }
//            default: break
//            }
//            
//        }
//    }
}


