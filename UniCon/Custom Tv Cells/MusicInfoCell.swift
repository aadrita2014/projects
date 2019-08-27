//
//  MusicInfoCell.swift
//  UniCon
//
//  Created by Ricky on 8/27/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MusicInfoCell: UITableViewCell {

    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var containerView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mImage.addCornerRadius()
        containerView.addCornerRadius()
        containerView.addDarkGrayBackgroundColor()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
