//
//  CustomActionSheetCell.swift
//  UniCon
//
//  Created by Ricky on 8/24/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class CustomActionSheetCell: UITableViewCell {

    @IBOutlet weak var actionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
