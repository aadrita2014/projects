//
//  Role.swift
//  UniCon
//
//  Created by Ricky on 10/11/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

enum Role: String {
    case client = "client"
    case creator = "creator"
    
    var role: String {
        switch self {
        case .client:
            return Role.client.rawValue
        case .creator:
            return Role.creator.rawValue
        }
    }
}
