//
//  Helpers.swift
//  UniCon
//
//  Created by Ricky on 9/1/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct StringHelpers {
    
    //Converts the number into formatted price string and also adds currency string at the end
    static func convertToPriceStr(fromVal:Int) -> String {
        let formattedStr = formatToNumberStr(val: fromVal)
//        if let currencySymbol = Locale.current.currencySymbol {
//            return "\(formattedStr)\(currencySymbol)"
//        }
//        else {
            return "\(formattedStr)원"
      //  }
    }
    static func convertToPriceStr(fromVal:String) -> String {
        if let intVal = Int(fromVal) {
            return convertToPriceStr(fromVal: intVal)
        }
        return ""
    }
    static func convertToPriceStr(fromVal:Double) -> String {
        let intVal = Int(fromVal)
        return convertToPriceStr(fromVal: intVal)
    }
    static func formatToNumberStr(val:Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: val)) else { return "" }
        return formattedNumber;
    }
    static func formatToNumberStr(val:Double) -> String {
        let intVal = Int(val)
        return formatToNumberStr(val: intVal)
    }
    static func formatToNumberStr(val:String) -> String {
        if let doubleVal = Double(val) {
            return formatToNumberStr(val: doubleVal)
        }
        return ""
    }
}
