//
//  GradientView.swift
//  UniCon
//
//  Created by Ricky on 9/17/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var gradientColor:[CGColor] = [] {
        didSet {
            updateViews()
        }
    }
    
    fileprivate var gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(gradientLayer)
    }
    func updateViews() {
        if gradientColor.count > 1 {
            applyGradient()
        }
        else {
            updateBackgroundColor()
        }
    }
    func applyGradient() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = [1.0, 0.0]
        backgroundColor = UIColor.clear
        
        
    }
    func updateBackgroundColor() {
        gradientLayer.removeFromSuperlayer()
        self.backgroundColor = UIColor(cgColor: self.gradientColor.first!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
}
