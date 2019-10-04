//
//  ReferralClientCell.swift
//  UniCon
//
//  Created by Ricky on 8/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ReferralClientCell: UICollectionViewCell {

    @IBOutlet weak var clientLogo: UIImageView!
    @IBOutlet weak var clientUsername: UIButton!
    @IBOutlet weak var clientBadge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clientLogo.addCornerRadius(radius: 10)
    }

}
