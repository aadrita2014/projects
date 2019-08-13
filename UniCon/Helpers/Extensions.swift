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
    func addCornerRadius(radius:CGFloat = 5.0)
    {
        let layer = self.layer
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}

extension UITextField {
    
    
    func addBottomBorder(color:UIColor = UIColor.white){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
    }
    func updatePlaceHolder(text:String = "", color:UIColor = AppColors.default_placeholder_color)
    {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
