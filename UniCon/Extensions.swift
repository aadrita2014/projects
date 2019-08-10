//
//  Extensions.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

extension UIView {
    func addDefaultBackgroundColor()
    {
        self.backgroundColor = UIColor(red: 3.0/255.0, green: 15.0/255.0, blue: 18.0/255.0, alpha: 1)
    }
}

extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
