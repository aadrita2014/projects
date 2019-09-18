//
//  MusicEditingPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MusicEditingPopupView: UIView {

    let kCONTENT_XIB_NAME = "MusicEditingView"
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var musicInfoLabel:UILabel!
    @IBOutlet weak var saveTrimmedMusicButton:UIButton!
    
    var selectedMusicModel:MusicInfo? {
        didSet {
           updateMusicLabel()
        }
    }
    var selectedAction:(()->Void)?
    
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
        saveTrimmedMusicButton.addCornerRadius()
    }
    func updateMusicLabel() {
         musicInfoLabel.text = selectedMusicModel!.title + " - " + selectedMusicModel!.artistInfo
    }
    @IBAction fileprivate func selectedClicked() {
        if let action = selectedAction {
            action()
        }
    }

}
