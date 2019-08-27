//
//  Extensions.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

extension UIView {
    
    //Helper methods to get the view width
    func viewWidth() -> CGFloat
    {
        return self.frame.size.width
    }
    //Helper methods to get the view height
    func viewHeight() -> CGFloat
    {
        return self.frame.size.height
    }
    
    //Add Background colors to the view
    func addDefaultBackgroundColor()
    {
        addBackgroundColor(color: AppColors.default_background_color)
    }
    func addBlackBackgroundColor()
    {
        addBackgroundColor(color: UIColor.black)
    }
    func addDarkGrayBackgroundColor()
    {
        addBackgroundColor(color: AppColors.gray_background_color)
    }
    private func addBackgroundColor(color:UIColor)
    {
        self.backgroundColor = color
    }
    //Helper method to add for rounded corners to the view
    func addCornerRadius(radius:CGFloat = 5.0)
    {
        let layer = self.layer
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    func addBorderColor(color: UIColor = UIColor.white)
    {
        let layer = self.layer
        layer.borderWidth = 0.5
        layer.borderColor = color.cgColor
    }
    //For Custom Written Views
    func fixInView(_ container: UIView!){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    @discardableResult
    public func addBlur(style: UIBlurEffect.Style = .extraLight) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }

}
//extension UIStackView {
//    
//    func addBackground(color: UIColor) {
//        let subview = UIView(frame: bounds)
//        subview.backgroundColor = AppColors.gray_background_color
//        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        insertSubview(subview, at: 0)
//    }
//    
//}
extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
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
