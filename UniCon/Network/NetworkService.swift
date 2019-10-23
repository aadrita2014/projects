//
//  Request.swift
//  UniCon
//
//  Created by Ricky on 10/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

import Alamofire
import PromiseKit
import EVReflection



protocol NetworkService
{
    static func POST<T:EVObject>(URL: String, parameters: [String: AnyObject]?, headers: [String: String]?, encoding: ParameterEncoding) -> Promise<T>
}
extension NetworkService
{
    // MARK: - POST
    static func POST<T:EVObject>(URL: String,
                        parameters: [String: AnyObject]? = nil,
                        headers: [String: String]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default) -> Promise<T>
    {
        let (promise, resolver) = Promise<T>.pending()
        Alamofire.request(URL,
                          method: .post,
        parameters: parameters,
        encoding: encoding,
        headers: headers).responseObject { (response: DataResponse<T>) in
            if AppConsts.DEBUG_MODE {
                print("API URL: \(URL)\nPARAMETERS: \(String(describing: parameters))\nRESULT: \(response)")
            }
            if let model = response.result.value as? BaseModel {
                if model.success {
                    resolver.fulfill(response.result.value!)
                }
                else {
                    print(NetworkError.requestFailedError.localizedDescription)
                    if model.message.isEmpty {
                        
                        resolver.reject(NetworkError.requestFailedError)
                    }
                    else {
                        resolver.reject(NetworkError.requestFailedError)
                    }
                }
            }
            else {
                if let result = response.result.value {
                    resolver.fulfill(result)
                }
                else {
                    if let error = response.error {
                        resolver.reject(error)
                    }
                    else {
                        resolver.reject(NetworkError.requestFailedError)
                    }
                }
            }
        }
        return promise
    }
    
 }

enum NetworkError: Error {
    case badJsonResponse
    case badUrl
    case requestFailedError
    case customError(String)
    
    var localizedDescription: String {
        switch self {
        case .requestFailedError:
            return "Request Failed"
        default:
            return "Request"
        }
    }
    var description: String {
        switch self {
        case .badJsonResponse:
                return "Unexpected values in JSON"
        case .badUrl:
                return "Bad url"
        case .requestFailedError:
                return "Request Failed"
        case .customError(let msg):
                return msg
        }
    }
}

class BaseModel:EVObject {
    var message:String = ""
    var success:Bool = false
}
