//
//  BookmarksCell.swift
//  UniCon
//
//  Created by Ricky on 11/7/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class BookmarksCell: UITableViewCell {

   @IBOutlet weak var containerView: UIView!
       @IBOutlet weak var participateButton: UIButton!
       @IBOutlet weak var dayCounterBtn: UIButton!
       override func awakeFromNib() {
           super.awakeFromNib()
           
           containerView.addDarkGrayBackgroundColor()
           containerView.addCornerRadius()
           dayCounterBtn.addCornerRadius()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
       
}
