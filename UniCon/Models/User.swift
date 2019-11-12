//
//  User.swift
//  UniCon
//
//  Created by Ricky on 10/4/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection

class User: EVObject, Codable{
    
    var timezone:String = ""
    var id:String = ""
    var email:String = ""
    var picture:String = ""
    var tempPassword:Bool = false
    var accountActivation:Bool = false
    var nickName:String = ""
    var phoneNumber:String = ""
    var role:String = ""
    var createdAt:String = ""
    var name:String = ""
//    var description: String {
//        return "User: { email: \(email), role: \(role) }"
//    }
    
    enum UserCodingKeys : String, CodingKey{
        case timezone = "timezone"
        case id = "id"
        case email = "email"
        case picture = "picture"
        case tempPassword = "tempPassword"
        case accountActivation = "accountActivation"
        case nickName = "nickName"
        case phoneNumber = "phoneNumber"
        case role = "role"
        case createdAt = "createdAt"
        case name = "name"
    }
    
    static func instance(dictionary: NSDictionary) -> User{
        let token = User(dictionary: dictionary)
        return token
    }
//
    required init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
         timezone = try (container.decodeIfPresent(String.self, forKey: .timezone) ?? "")
         id = try (container.decodeIfPresent(String.self, forKey: .id) ?? "")
         email = try (container.decodeIfPresent(String.self, forKey: .email) ?? "")
        picture = try (container.decodeIfPresent(String.self, forKey: .picture) ?? "")
         tempPassword = try (container.decodeIfPresent(Bool.self, forKey: .tempPassword) ?? false)
         accountActivation = try (container.decodeIfPresent(Bool.self, forKey: .accountActivation) ?? false)
         nickName = try (container.decodeIfPresent(String.self, forKey: .nickName) ?? "")
         phoneNumber = try (container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? "")
         role = try (container.decodeIfPresent(String.self, forKey: .role) ?? "")
         createdAt = try (container.decodeIfPresent(String.self, forKey: .createdAt) ?? "")
         name = try (container.decodeIfPresent(String.self, forKey: .name) ?? "")
    }
    func encode(to encoder: Encoder) throws {
       var container = try encoder.container(keyedBy: UserCodingKeys.self)
        try container.encodeIfPresent(timezone, forKey: .timezone)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(picture, forKey: .picture)
        try container.encodeIfPresent(tempPassword, forKey: .tempPassword)
        try container.encodeIfPresent(accountActivation, forKey: .accountActivation)
        try container.encodeIfPresent(nickName, forKey: .nickName)
        try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(name, forKey: .name)
    }
    
//    func setValue(value: AnyObject!, forUndefinedKey key: String) {
//           switch key {
//           default:
//               print("---> setValue for key '\(key)' should be handled.")
//           }
//    }
}




