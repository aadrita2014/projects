//
//  StickerCell.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class StickerCell: UICollectionViewCell {

    @IBOutlet weak var stickerImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setModel(model:StickerModel) {
        stickerImageView.image = UIImage(named:model.image)
    }

}
