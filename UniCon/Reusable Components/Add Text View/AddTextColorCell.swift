//
//  AddTextColorCell.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class AddTextColorCell: UICollectionViewCell {

    @IBOutlet var bgView:UIView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        bgView.addCornerRadius(radius: bgView.viewWidth()/2)
    }
}
