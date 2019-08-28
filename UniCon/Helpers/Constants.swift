//
//  Constants.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct AppColors {
    static let default_placeholder_color = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    static let default_red_color = UIColor(red: 191.0/255.0, green: 8.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    static let default_background_color = UIColor(red: 3.0/255.0, green: 15.0/255.0, blue: 18.0/255.0, alpha: 1)
    
    static let gray_background_color = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 15.0/255.0, alpha: 1.0)
    
}

struct Defaults {
    static func saveString(key:String,value:String){
        UserDefaults.standard.set(value, forKey: key)
    }
    static func getString(key:String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    static func saveBool(key:String,value:Bool){
        UserDefaults.standard.set(value, forKey: key)
    }
    static func getBool(key:String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
}

struct StringConsts {
    static let isClientSaveKey = "is_client_save_key"
}
