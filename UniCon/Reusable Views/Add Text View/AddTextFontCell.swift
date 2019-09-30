//
//  AddTextFontCell.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class AddTextFontCell: UICollectionViewCell {

    @IBOutlet weak var fontText:UILabel!
    

    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure() {
        contentView.addCornerRadius(radius: 5)
    }

}
