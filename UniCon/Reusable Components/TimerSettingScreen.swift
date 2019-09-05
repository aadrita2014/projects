//
//  TimerSettingScreen.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class TimerSettingScreen: UIView {
    
    
    let kCONTENT_XIB_NAME = "TimerSettingScreen"
    @IBOutlet var contentView: UIView!
    var startTimerAction:(()->Void)?
 
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
    }
    @IBAction fileprivate func startTimerClicked() {
        if let action = startTimerAction {
            action()
        }
    }
}
