//
//  FilterPopupCell.swift
//  UniCon
//
//  Created by Ricky on 9/3/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class FilterPopupCell: UICollectionViewCell {

    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterName: UILabel!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
            filterImage.addCornerRadius(radius: filterImage.viewWidth()/2)
    }
    func setModel(model:FilterModel) {
        filterImage.image = UIImage(named: model.image)
        filterName.text = model.name
    }
}
