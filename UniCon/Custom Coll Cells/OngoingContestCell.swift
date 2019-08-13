//
//  OngoingContestCell.swift
//  UniCon
//
//  Created by Ricky on 8/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class OngoingContestCell: UICollectionViewCell {

    @IBOutlet weak var contestImage: UIImageView!
    @IBOutlet weak var contestTitle: UILabel!
    @IBOutlet weak var contestTime: UILabel!
    @IBOutlet weak var contestPrize: UILabel!
    @IBOutlet weak var contestingPeople: UILabel!
    @IBOutlet weak var respondButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    var respondClicked:((OngoingContestCell) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //From The Custom Extension in Extensions.swift
        self.contentView.addCornerRadius(radius: 10)
        self.contentView.addDefaultBackgroundColor()
        otherButton.addCornerRadius(radius: 4)
        respondButton.addCornerRadius(radius: 10)
        //Respond Button Selected & Non-Selected States
        
        respondButton.setTitle("참여하기", for: .normal)
        respondButton.setTitleColor(UIColor.white, for: .normal)
        
        respondButton.setTitle("참여중", for: .selected)
        respondButton.setTitleColor(AppColors.default_red_color, for: .selected)
        
        updateButtonStatus()
        
    }
    
    @IBAction func respondToEventClicked(_ sender: UIButton) {
        
        respondButton.isSelected = !respondButton.isSelected
        updateButtonStatus()
        if let action = respondClicked
        {
            action(self)
        }
    }
    func updateButtonStatus()
    {
        if respondButton.isSelected
        {
            respondButton.backgroundColor = UIColor.white
        }
        else
        {
            respondButton.backgroundColor = AppColors.default_red_color
        }
    }
    
}
