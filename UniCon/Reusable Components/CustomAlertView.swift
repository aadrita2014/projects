//
//  CustomAlertView.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class CustomAlertView:UIView {
    
    let kCONTENT_XIB_NAME = "CustomAlertView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var dismissBtn:UIButton!
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
    init(frame:CGRect,title:String?,desc:String?,btnTitle:String?)
    {
        super.init(frame: frame)
       
    }
    func commonInit() {
        //Loading the view from the nib file
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        containerView.addCornerRadius(radius: 15)
        
//        titleLabel.text = title
//        descLabel.text = desc
//        dismissBtn.setTitle(btnTitle, for: .normal)
       
    }
    @IBAction func dismissView(_ sender: UIButton) {
        if let action = dismissClicked {
            action()
        }
    }
}
