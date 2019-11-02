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
    
//    var description: String {
//        return "User: { email: \(email), role: \(role) }"
//    }
    
    static func instance(dictionary: NSDictionary) -> User{
        let token = User(dictionary: dictionary)
        return token
    }
//
    required init() {
        
    }
    
    
}




