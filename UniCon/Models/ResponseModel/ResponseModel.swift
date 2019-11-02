//
//  ResponseModel.swift
//  UniCon
//
//  Created by Ricky on 10/24/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
//import EVReflection

class ResponseModel:Codable {
    var message:String = ""
    var code:Int = 0
//    enum CodingKeys: String, CodingKey {
//        case message
//        case success
//        case token
//    }
//
    var description: String {
        return "Response: { message: \(message), code: \(code) }"
    }
}
class RegisterResponseModel:Codable {
    var success:Bool = false
    var user: User?
    var token:Token?
    var message:String = ""
}
class UserResponseModel:Codable {
   
    var token:Token?
    var user:User?
    
    static func instance(token:Token?,user:User?) -> UserResponseModel?{
        guard let token = token, let user = user else { return nil }
        let model = UserResponseModel()
        model.token = token
        model.user = user
        return model
    }
}



