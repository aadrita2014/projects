//
//  MusicCategoryCell.swift
//  UniCon
//
//  Created by Ricky on 9/2/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MusicCategoryCell: UICollectionViewCell {

    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setModel(model:MusicCategory) {
        catImage.image = UIImage(named: model.image)
        catName.text = model.name
        if model.isFavoriteCategory {
            
            catImage.contentMode = .scaleAspectFit
            catImage.addCornerRadius()
            catImage.addBorderColor(borderWidth: 0.5, color: AppColors.default_red_color)
        }
        else {
            catImage.addCornerRadius(radius: 0)
            catImage.contentMode = .scaleAspectFill
            catImage.addBorderColor(borderWidth: 0, color: UIColor.clear)
        }
    }
}
