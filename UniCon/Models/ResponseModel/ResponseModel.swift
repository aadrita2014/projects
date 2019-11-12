//
//  ResponseModel.swift
//  UniCon
//
//  Created by Ricky on 10/24/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection

class ResponseModel:Codable {
    var message:String = ""
    var code:Int = 0
    
    var description: String {
        return "Response: { message: \(message), code: \(code) }"
    }
}
class RegisterResponseModel:EVObject, Codable {
    var success:Bool = false
    var user: User?
    var token:Token?
    var message:String = ""
    
    required init () {
        
    }
}
class createCcontestResponseModel:EVObject, Codable {
    var success:Bool = false
    var user: User?
    var token:Token?
    var message:String = ""
    
    required init () {
        
    }
}
//class UserResponseModel:ResponseModel {
   class UserResponseModel:NSObject, Codable {
    var token = Token()
    var user = User()
    
    enum UserResponseCodingKeys : String, CodingKey {
        case token = "token"
        case user = "user"
    }
    
    
    static func instance(token:Token?,user:User?) -> UserResponseModel?{
        guard let user = user else { return nil }
        let model = UserResponseModel()
        if let token = token {
            model.token = token
        }
        model.user = user
        return model
    }
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserResponseCodingKeys.self)
        token = try (container.decodeIfPresent(Token.self, forKey: .token) ?? Token())
        user = try (container.decodeIfPresent(User.self, forKey: .user) ?? User())
    }
    func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: UserResponseCodingKeys.self)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(token, forKey: .token)
    }
}



