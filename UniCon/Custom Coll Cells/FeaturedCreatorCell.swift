//
//  FeaturedCreatorCell.swift
//  UniCon
//
//  Created by Ricky on 8/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class FeaturedCreatorCell: UICollectionViewCell {

    @IBOutlet weak var creatorProfilePic: UIImageView!
    
    @IBOutlet weak var creatorbadge: UIImageView!
    
    @IBOutlet weak var creatorUsername: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // From The Custom Extension in Extensions.swift
        self.contentView.addCornerRadius(radius: 10)
    }

}
