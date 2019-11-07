//
//  APIRequest.swift
//  UniCon
//
//  Created by Ricky on 10/11/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//MARK: BASE API Routes
struct APIRouter {

    static let API_HOST = "http://52.79.128.120"
    static let API_PORT = ":8080"
    static let API_VERSION = "v1"
    static let API_ROOT = API_HOST + API_PORT + "/" + API_VERSION
    
}
//MARK: Authentication API Calls
extension APIRouter {
   static let AUTH_PATH = API_ROOT + "/auth/"
    static let CONTENT_PATH = API_ROOT + "/contest/"
   static let LOGIN =  AUTH_PATH + "login"
   static let REFRESH_TOKEN = AUTH_PATH + "refresh-token"
   static let REGISTER = AUTH_PATH + "register"
}
