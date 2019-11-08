//
//  AuthenticationManager.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
import EVReflection
import Alamofire
import MobileCoreServices

struct AuthenticationService:NetworkService {
    static func authenticate(username:String, password:String,role:String) -> Promise<Void> {
        let request = TokenRequest(username: username, password: password, role: role)
        return TokenManager.requestToken(request: request)
//        let parameters = request.toDictionary(.DefaultDeserialize) as! [String : AnyObject]
//        return POST(URL:APIRouter.LOGIN, parameters: parameters)
    }
    static func registerNewUser(params:[String:String],completion: @escaping  (_ response:RegisterResponseModel?,_ error:String?) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
        for key in params.keys {
                if let value = params[key] {
                    multipartFormData.append(Data(value.utf8), withName: key)
                    }
                }
        }, to: APIRouter.REGISTER)
                .responseJSON { (response) in
                    print(response)
                    switch response.result {
                    case .success(let result):
                        if let dict = result as? [String:Any] {
                            let model = RegisterResponseModel(dictionary: dict as NSDictionary)
                            if model.success {
                                completion(model,nil)
                            }
                            else {
                                completion(nil,model.message)
                            }
                        }
                        else {
                            completion(nil,"Request Failed")
                        }
                    case .failure(let error):
                        completion(nil,error.localizedDescription)
                    }
                    
        }
    }
    func contestCreateApi(contestCreate: CreateContestRequest,completion: @escaping  (_ response:NSDictionary?,_ error:String?) -> Void) {
//        createContestregRequest
//        DispatchQueue.global(qos: .userInitiated).async {
        
        let request: URLRequest

        do {
            request = try createRequest(contestCreate: contestCreate)
        } catch {
            print(error)
            DispatchQueue.main.async {
            completion(nil,error.localizedDescription)
            }
            return
        }

//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print("hulk da",data)
//            guard let dataResponse = data, error == nil else {
//                // handle error here
//                print(error ?? "Unknown error")
//                return
//            }
//
//            // parse `data` here, then parse it
//            do{
//                 //here dataResponse received from a network request
//                 let jsonResponse = try JSONSerialization.jsonObject(with:
//                                        dataResponse, options: [])
//                 print(jsonResponse) //Response result
//                completion(jsonResponse,nil)
//              } catch let parsingError {
//                 print("Error", parsingError)
//            }
//            // note, if you want to update the UI, make sure to dispatch that to the main queue, e.g.:
//            //
//
//            DispatchQueue.main.async {
//                completion(nil,nil)
//            }
//
//            // DispatchQueue.main.async {
//            //     // update your UI and model objects here
//            // }
//        }
//
//        task.suspend()
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
            print("anything")
             guard let dataResponse = data, error == nil else {
                            // handle error here
                            print(error ?? "Unknown error")
                            return
                        }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
//                    self.teamResult = jsonResult
                    print(jsonResult)
                    //Use GCD to invoke the completion handler on the main thread
                    DispatchQueue.main.async() {
                      completion(jsonResult,nil)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
        
    }
    /// Create request
    ///
    /// - parameter userid:   The userid to be passed to web service
    /// - parameter password: The password to be passed to web service
    /// - parameter email:    The email address to be passed to web service
    ///
    /// - returns:            The `URLRequest` that was created

    func createRequest(contestCreate:CreateContestRequest) throws -> URLRequest {
        let parameters = [
            "userId"  : "5dc1245aac32d73663c68d09",
            "title"    : "title",
            "grade" : "grade","contactName" : contestCreate.contactName,"contactPhone" : contestCreate.contactPhone,"startTime" : contestCreate.startTime,"endTime" : contestCreate.endTime,"examinationStartTime" : contestCreate.examinationStartTime,"examinationEndTime" : contestCreate.examinationEndTime,"publicationTime" : contestCreate.publicationTime,"totalPrize" : contestCreate.totalPrize,"platformFee" : contestCreate.platformFee,"first" : contestCreate.first,"second" : contestCreate.second,"third" : contestCreate.third,"content" : contestCreate.content]
        // build your dictionary however appropriate
     print("parameters data",parameters)
        let boundary = generateBoundaryString()

        let url = URL(string: APIRouter.CONTENT_PATH + "5dc1245aac32d73663c68d09/create-contest" )!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NzU2ODEwNDgsImlhdCI6MTU3MzA1MzA0OCwic3ViIjoiNWRjMTI0NWFhYzMyZDczNjYzYzY4ZDA5In0.7fg9oZUsfmE0vfcAckpK3h3EGRQvuKpAIbANASN1r7E", forHTTPHeaderField: "Authorization")

        let path1 = contestCreate.referenceImage
         let path2 = contestCreate.guideVideUrl
         let path3 = contestCreate.guideVideThumbnailUrl
       print("god of war",path1,path2,path3)
        request.httpBody = try createBody(with: parameters, filePathKey: ["referenceImage","guideVideUrl","guideVideThumbnailUrl"], paths: [path1,path2,path3], boundary: boundary)

        return request
    }

    /// Create body of the `multipart/form-data` request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter paths:        The optional array of file paths of the files to be uploaded
    /// - parameter boundary:     The `multipart/form-data` boundary
    ///
    /// - returns:                The `Data` of the body of the request

    private func createBody(with parameters: [String: String]?, filePathKey: [String], paths: [String], boundary: String) throws -> Data {
        var body = Data()

        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }

        for (index ,path) in paths.enumerated() {
            let url = URL(fileURLWithPath: path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(for: path)

            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey[index])\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }

        body.append("--\(boundary)--\r\n")
        return body
    }

    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.

    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }

    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires `import MobileCoreServices`.
    ///
    /// - parameter path:         The path of the file for which we are going to determine the mime type.
    ///
    /// - returns:                Returns the mime type if successful. Returns `application/octet-stream` if unable to determine mime type.

    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension

        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
