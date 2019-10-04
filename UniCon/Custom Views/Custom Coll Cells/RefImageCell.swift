//
//  RefImageCell.swift
//  UniCon
//
//  Created by Ricky on 8/30/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class RefImageCell: UICollectionViewCell {

    @IBOutlet weak var refImage: UIImageView!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var deletebtn: UIButton!
    
    
    var addAction:((RefImageCell)->Void)?
    var delAction:((RefImageCell)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.refImage.addBorderColor(borderWidth: 0.5, color: AppColors.gray_background_color)
        self.refImage.addCornerRadius(radius: 2)
    }
    @IBAction func addImageClicked() {
        if let action = addAction {
            action(self)
        }
    }
    
    @IBAction func deleteImgClicked() {
        if let action = delAction {
            action(self)
        }
    }

}
