//
//  FeedSharedPopUpPrimary.swift
//  UniCon
//
//  Created by Ricky on 8/23/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class FeedSharedPopUpPrimary: UIView {
    
    let kCONTENT_XIB_NAME = "FeedSharedPopUpPrimary"
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var creatorProfilePic: UIImageView!
    @IBOutlet weak var earnedAmount: UILabel!
    
    var dismissClicked:(()->Void)?
    //MARK: View Setup Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //Contents of a nib file are unarchived
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        //Loading the view from the nib file
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        containerView.addCornerRadius(radius: 15)
        creatorProfilePic.addCornerRadius(radius: creatorProfilePic.viewWidth()/2)
        
    }
    @IBAction func dismissView(_ sender: UIButton) {
        if let action = dismissClicked {
            action()
        }
    }
}
