//
//  Constants.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct AppColors {
    
    //Primay Colors
    static let default_placeholder_color = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    static let default_red_color = UIColor(red: 191.0/255.0, green: 8.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    static let default_background_color = UIColor(red: 3.0/255.0, green: 15.0/255.0, blue: 18.0/255.0, alpha: 1)
    static let gray_background_color = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 15.0/255.0, alpha: 1.0)
    
    
    //Colors for text for add text screen
    static let redTextColor = UIColor(red: 235.0/255.0, green: 87.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    static let orangeTextColor = UIColor(red: 242.0/255.0,green: 153.0/255.0,blue:74.0/255.0, alpha: 1.0)
    static let yellowTextColor = UIColor(red: 242.0/255.0, green: 201.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    static let greenTextColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    static let royalBlueTextColor = UIColor(red: 47.0/255.0, green: 128.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    static let cyanTextColor = UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static let pinkTextColor = UIColor(red: 187.0/255.0, green: 107.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    static let grayTextColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    static let whiteTextColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static let lighGreenTextColor = UIColor(red: 111.0/255.0, green: 207.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    
    
    //Filter Colors
    static let pinkFlueFilterColor = UIColor(red: 250.0/255.0, green: 36.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    static let whiteFilterColor = UIColor.white
    static let bluesFilterColor = UIColor(red: 79.0/255.0, green: 76.0/255.0, blue: 224.0/255.0, alpha: 0.2)
    static let mandarinFilterColor = UIColor(red: 212.0/255.0, green: 224.0/255.0, blue: 76.0/255.0, alpha: 0.2)
    static let greenTeaFilterColor = UIColor(red:76.0/255.0,green: 224.0/255.0,blue: 82.0/255.0, alpha: 0.2)
    static let redWineFilterColor = UIColor(red: 191.0/255.0, green: 8.0/255.0, blue: 24.0/255.0, alpha: 0.2)
    
    
    //Gradient Colors works with cgColor only
    static let pinkFlueGradient = [AppColors.pinkFlueFilterColor.cgColor,UIColor.clear.cgColor]
    static let whiteGradient = [AppColors.whiteFilterColor.cgColor,UIColor.clear.cgColor]
    static let bluesGradient = [AppColors.bluesFilterColor.cgColor]
    static let greenTeaGradient = [AppColors.greenTeaFilterColor.cgColor]
    static let redWineGradient = [AppColors.redWineFilterColor.cgColor]
    static let mandarinGradient = [AppColors.mandarinFilterColor.cgColor]
    
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

struct AppConsts {
    //Static Consts before getting from the API
    static let DEBUG_MODE = true
    static let MAX_LENGTH_VIDEO = 60.0
    static let MIN_LENGTH_VIDEo = 5.0
}
