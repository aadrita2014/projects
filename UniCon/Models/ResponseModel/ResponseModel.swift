//
//  ResponseModel.swift
//  UniCon
//
//  Created by Ricky on 10/24/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection

class ResponseModel:Decodable {
    var message:String = ""
    var success:Bool = false
    var token:String?
    
    
    enum CodingKeys: String, CodingKey {
        case message
        case success
        case token
    }
    
    var description: String {
        return "Response: { message: \(message), success: \(success) }"
    }
}

