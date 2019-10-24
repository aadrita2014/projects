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
    static func POST<T:Decodable>(URL: String, parameters: [String: Any]?, headers: [String: String]?, encoding: ParameterEncoding) -> Promise<T>
}
extension NetworkService
{
    // MARK: - POST
    static func POST<T:Decodable>(URL: String,
                                  parameters: [String: Any]? = nil,
                                  headers: [String: String]? = nil,
                                  encoding: ParameterEncoding = URLEncoding.default) -> Promise<T>
    {
        let (promise, resolver) = Promise<T>.pending()
        AF.request(URL,method: .post,parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseDecodable { (response:DataResponse<T,AFError>) in
            if AppConsts.DEBUG_MODE {
                print("API URL: \(URL)\nPARAMETERS: \(String(describing: parameters))\nRESULT: \(response)")
            }
            switch(response.result)
            {
            case .success(_):
                
                if let model = response.value as? ResponseModel {
                    print(model.description)
                    if model.success {
                        resolver.fulfill(response.value!)
                    }
                    else {
                        if model.message.isEmpty {
                            resolver.reject(NetworkError.requestFailedError)
                        }
                        else {
                            resolver.reject(NetworkError.customError(model.message))
                        }
                    }
                }
                //                    if let value = response.value {
                //                        resolver.fulfill(value)
                //                    }
                //                    else {
                //                        let errorD = response.result.mapError { (error) -> Error in
                //                            return error
                //                        }
                //                        resolver.reject(NetworkError.customError("Bad Request"))
            //                }
            case .failure(let error):
                resolver.reject(error)
                
            }
        }
        //        Alamofire.request(URL,
        //                          method: .post,
        //        parameters: parameters,
        //        headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseObject { (response: DataResponse<T>) in
        //            if AppConsts.DEBUG_MODE {
        //                print("API URL: \(URL)\nPARAMETERS: \(String(describing: parameters))\nRESULT: \(response)")
        //            }
        //            if let model = response.result.value as? ResponseModel {
        //                if model.success {
        //                    resolver.fulfill(response.result.value!)
        //                }
        //                else {
        //                    if model.message.isEmpty {
        //                        resolver.reject(NetworkError.requestFailedError)
        //                    }
        //                    else {
        //                        resolver.reject(NetworkError.customError(model.message))
        //                    }
        //                }
        //            }
        //            else {
        //                if let result = response.result.value {
        //                    resolver.fulfill(result)
        //                }
        //                else {
        //                    if let error = response.error {
        //                        resolver.reject(error)
        //                    }
        //                    else {
        //                        resolver.reject(NetworkError.requestFailedError)
        //                    }
        //                }
        //            }
        //        }
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

