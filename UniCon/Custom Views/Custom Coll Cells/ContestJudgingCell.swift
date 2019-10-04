//
//  ContestJudgingCell.swift
//  UniCon
//
//  Created by Ricky on 8/12/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestJudgingCell: UICollectionViewCell {

    @IBOutlet weak var contestImage: UIImageView!
    @IBOutlet weak var contestTitle: UILabel!
    @IBOutlet weak var contestTime: UILabel!
    @IBOutlet weak var contestPrize: UILabel!
    @IBOutlet weak var contestingPeople: UILabel!
    @IBOutlet weak var respondButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //From The Custom Extension in Extensions.swift
        self.contentView.addCornerRadius(radius: 10)
        self.contentView.addDefaultBackgroundColor()
        otherButton.addCornerRadius(radius: 4)
        respondButton.addCornerRadius(radius: 10)
        
    }
    @IBAction func respondToEventClicked(_ sender: UIButton) {
    }
}
