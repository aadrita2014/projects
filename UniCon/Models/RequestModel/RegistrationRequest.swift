//
//  TempRegModel.swift
//  UniCon
//
//  Created by Ricky on 10/21/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection

class RegistrationRequest:EVObject {
    
    var email:String = ""
    var name:String = ""
    var password:String = ""
    var nickName:String = ""
    var phoneNumber:String = ""
    var role:String = ""
    
    required init() {
        
    }
}
