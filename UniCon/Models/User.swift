//
//  User.swift
//  UniCon
//
//  Created by Ricky on 10/4/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection



class UserResponseModel:ResponseModel{
    var user: User?
    
    override var description: String {
        return user?.description ?? ""
    }
    
}
class User: Decodable {
    
    var tokenType:String = ""
    var accessToken:String = ""
    var refreshToken:String = ""
    var expiresIn:Int = 0
    var timezone:String = ""
    var id:String = ""
    var email:String = ""
    var role:String = ""
    var createdAt:String = ""
   
    var description: String {
        return "User: { email: \(email), role: \(role) }"
    }
}


