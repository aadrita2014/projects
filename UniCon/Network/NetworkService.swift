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


enum NetworkError: Error {
    case badJsonResponse
    case badUrl
    var localizedDescription: String {
        switch self {
        case .badJsonResponse:
            return "Unexpected values in JSON"
        case .badUrl:
            return "Bad url"
        }
    }
}
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
                        encoding: ParameterEncoding) -> Promise<T>
    {
        let (promise, resolver) = Promise<T>.pending()
        Alamofire.request(URL,
                          method: .post,
        parameters: parameters,
        encoding: encoding,
        headers: headers).responseObject { (response: DataResponse<T>) in
            if let result = response.result.value {
                resolver.fulfill(result)
            }
            else {
                if let error = response.error {
                    resolver.reject(error)
                }
                else {
                    resolver.reject(NetworkError.badJsonResponse)
                }
            }
        }
        return promise
    }
 }
