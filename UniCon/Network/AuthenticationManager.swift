//
//  AuthenticationManager.swift
//  UniCon
//
//  Created by Ricky on 10/9/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import PromiseKit
struct AuthenticationManager
{
    static func authenticate(username:String!, password:String!) -> Promise<Void>
    {
        let request = TokenRequest(username: username, password: password)
        return TokenManager.requestToken(request: request)
    }
}
