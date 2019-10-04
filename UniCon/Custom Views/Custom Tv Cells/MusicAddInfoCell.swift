//
//  MusicAddInfoCell.swift
//  UniCon
//
//  Created by Ricky on 9/2/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MusicAddInfoCell: UITableViewCell {

    
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var musicSelectedAction:((MusicAddInfoCell) -> Void)?
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
        
        cellSetup()
        
    }
    
    func cellSetup() {
        favoriteBtn.setImage(UIImage(named: "iconFavorite"), for: .normal)
        favoriteBtn.setImage(UIImage(named: "iconFavoriteActive"), for: .selected)
        
        selectedButton.setImage(UIImage(named: "iconSelect"), for: .normal)
        selectedButton.setImage(UIImage(named: "iconSelectActive"), for: .selected)
        
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
    }
    
    @IBAction func selectedClicked(_ sender: UIButton) {
        selectedButton.isSelected = !selectedButton.isSelected
        
        if selectedButton.isSelected {
            if let action = musicSelectedAction {
                action(self)
            }
        }
    }
}
