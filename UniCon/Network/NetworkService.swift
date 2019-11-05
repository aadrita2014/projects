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
    static var authorizedHeader:HTTPHeaders    {
        guard let accessToken = TokenManager.token?.accessToken else
        {
            return ["Authorization": ""]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
    static func POST<T:Codable>( URL: String, parameters: [String: Any]?, headers: [String: String]?, encoding: ParameterEncoding) -> Promise<T>
    {
        let (promise, resolver) = Promise<T>.pending()
        
        AF.request(URL,method: .post,parameters: parameters, headers: authorizedHeader).responseDecodable { (response:DataResponse<T,AFError>) in
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
                    else {
                        resolver.fulfill(value)
                    }
                }
                catch let exception {
                    print(exception)
                    resolver.reject(NetworkError.badJsonResponse)
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

