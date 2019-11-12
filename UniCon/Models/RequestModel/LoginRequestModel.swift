//
//  LoginRequestModel.swift
//  UniCon
//
//  Created by Gaurav Shishodia on 11/11/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class LoginRequestModel:NSObject, NetworkHandlerDelegate, Codable{
   
    var email : String?
    var password : String?
    var role: String?
    
    enum loginRequestKeys : String, CodingKey{
        case email = "email"
        case password = "password"
        case role = "role"
    }
    override init() {
        email = "kgadmin@gmail.com"
        password = "123456"
        role = "admin"
    }
    
    required init(from decoder: Decoder) throws{
        
        let container = try decoder.container(keyedBy: loginRequestKeys.self)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        role = try container.decodeIfPresent(String.self, forKey: .role)
        
    }

    func encode(to encoder: Encoder) throws{
        var container = try encoder.container(keyedBy: loginRequestKeys.self)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(role, forKey: .role)
    }
    
    //MARK:- LoginApiIntegration
    func callLoginApi(completion: @escaping(Bool,UserResponseModel?, String?) -> Void){
        
        NetworkHandler.sharedInstance.callNetworkApi(type: .post, requestUrlString: APIRouter.LOGIN, delegate: self) { (data, success, message) in
            if success == true{
                guard let dataInfo = data else {
                    completion(false, nil,nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                let userResModel = try decoder.decode(UserResponseModel.self, from: dataInfo)
                    completion(true, userResModel,nil)
                }
                catch let error {
                    completion(false, nil,error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func getRequestBody(requestUrl: URL) -> Data? {
//        let dict = ["email": self.email ?? "",
//                    "password": self.password ?? "",
//                    "role": self.role ?? ""]
        do{
//            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return data
        }catch{
            return nil
        }
        
    }
       
       
}
