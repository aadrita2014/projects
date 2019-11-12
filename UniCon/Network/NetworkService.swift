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
//import EVReflection

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


enum NetworkCallType : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case batch = "BATCH"
}

protocol NetworkHandlerDelegate {
    func getRequestBody(requestUrl : URL) -> Data?
}

public class NetworkHandler: NSObject {
    
    var authorizedHeader : [String: String]{
        guard let accessToken = TokenManager.token?.accessToken else
        {
            return ["Authorization": "", "Content-Type" : "application/json"]
        }
        return ["Authorization": "Bearer \(accessToken)","Content-Type" : "application/json"]
    }
    
    static let sharedInstance = NetworkHandler()
    
    
    var delegate: NetworkHandlerDelegate?
    
    func callNetworkApi(type : NetworkCallType, requestUrlString : String, delegate : NetworkHandlerDelegate, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
        guard let requestUrl = URL(string: requestUrlString) else { return }
        self.delegate = delegate
        switch type {
        case .get:
            callGetRequest(requestUrl: requestUrl, completionBlock: completionBlock)
        case .post:
            callPostRequest(requestUrl: requestUrl, bodyData: self.delegate?.getRequestBody(requestUrl: requestUrl), completionBlock: completionBlock)
        case .put:
            callPutRequest(requestUrl: requestUrl)
        case .batch:
            callBatchRequest(requestUrl: requestUrl)
        default:
            print("Error: Api Type not hanlded")
        }
    }
    //MARK:- GET Implementation
    
    private func callGetRequest(requestUrl: URL, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
        let urlSession = URLSession(configuration: .default)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = NetworkCallType.get.rawValue
        request.allHTTPHeaderFields = authorizedHeader
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) -> Void in
           self.handleResponse(data: data, response: response, error: error, completionBlock: completionBlock)
        }
        dataTask.resume()
        
    }
    //MARK:- POST Implementation
    
    private func callPostRequest(requestUrl: URL, bodyData: Data?, completionBlock: @escaping ( Data?, Bool, String?) -> Void)
    {

        let request = NSMutableURLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = authorizedHeader
        request.httpBody = bodyData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            self.handleResponse(data: data, response: response, error: error, completionBlock: completionBlock)
        })

        dataTask.resume()
    }
    
    //MARK:- PUT Implementation
    private func callPutRequest(requestUrl: URL){
        
    }
    //MARK:- BATCH Implementation
    private func callBatchRequest(requestUrl: URL){
        
    }
    //MARK:- RESPONSE handling implementation
    func handleResponse(data: Data?,response: URLResponse?,error: Error?, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
         if (error != nil) {
           completionBlock(nil, false, error.debugDescription)
         } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200{
           completionBlock(nil,false,"Error in received Status Code : \(httpResponse.statusCode)")
         }
         else {
               completionBlock(data,true,nil)
         }
    }
}

