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
}
