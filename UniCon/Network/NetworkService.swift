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
    static func POST<T:Codable>(URL: String, parameters: [String: Any]?, headers: [String: String]?, encoding: ParameterEncoding) -> Promise<T>
}
extension NetworkService
{
    // MARK: - POST
    static func POST<T:Codable>(URL: String,
                                parameters: [String: Any]? = nil,
                                headers: [String: String]? = nil,
                                encoding: ParameterEncoding = URLEncoding.default) -> Promise<T>
    {
        let (promise, resolver) = Promise<T>.pending()
        AF.request(URL,method: .post,parameters: parameters).responseDecodable { (response:DataResponse<T,AFError>) in
            
            if AppConsts.DEBUG_MODE {
                print("Response: \(response.debugDescription)")
            }
            //If it generates error
            if let error = response.error {
                resolver.reject(error)
            } else {
                do {
                    //try to convert to models
                    let value = try response.result.get()
                    if let responseModel = value as? ResponseModel {
                        resolver.reject(NetworkError.customError(responseModel.message))
                    }
                    resolver.fulfill(value)
                }
                catch let exception {
                    print(exception)
                    resolver.reject(NetworkError.badJsonResponse)
                }
            }
            
        }
        //        AF.request(URL, method: .post, parameters: parameters).responseData { (response: DataResponse<UserResponseModel>) in
        //                    if AppConsts.DEBUG_MODE {
        //                        print("API URL: \(URL)\nPARAMETERS: \(String(describing: parameters))\nRESULT: \(response)")
        //                    }
        //                    if let model = response.result.value {
        //                        if model.success {
        //                            resolver.fulfill(response.result.value!)
        //                        }
        //                        else {
        //                            if model.message.isEmpty {
        //                                resolver.reject(NetworkError.requestFailedError)
        //                            }
        //                            else {
        //                                resolver.reject(NetworkError.customError(model.message))
        //                            }
        //                        }
        //                    }
        //                    else {
        //                        if let result = response.result.value {
        //                            resolver.fulfill(result)
        //                        }
        //                        else {
        //                            if let error = response.error {
        //                                resolver.reject(error)
        //                            }
        //                            else {
        //                                resolver.reject(NetworkError.requestFailedError)
        //                            }
        //                        }
        //                    }
        //                }
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

