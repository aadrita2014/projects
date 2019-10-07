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

/*
 An `Request` is a protocol to which structs can conform to create expressive REST API requests.
 */
protocol Request: CustomStringConvertible {
    associatedtype ResponseType
    
    var host: String { get }
    var api: APIVersion { get }
    var route: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any] { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
    
//    func process(json: JSON) throws -> ResponseType
}

extension Request {
    var description: String {
        return "\(method) request to \(route) with \(encoding), \(parameters) and \(headers)"
    }
}

enum APIVersion: String {
    case none = ""
    case v1 = "/v1"
    case v2 = "/v2"
}

extension Request {
    var host: String {
        return "https://dan.iel.li"
    }
    
    var api: APIVersion { return .v2 }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any] { return [:] }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var headers: HTTPHeaders { return [:] }
    
    func make(completion: @escaping (Promise<ResponseType>)-> Void)  {
        guard let url = URL(string: host + api.rawValue + route) else {
            completion(Promise(error: NetworkError.badUrl))
            return
        }
        
        Alamofire
            .request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseJSON
                
        }
        
        
    }
}

/*
 `NetworkError` represents custom errors from networking
 */
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

