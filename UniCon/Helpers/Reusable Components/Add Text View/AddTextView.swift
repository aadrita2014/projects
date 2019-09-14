//
//  AddTextView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

//
//  AddStickersPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct FontModel {
    let image, name:String
}
struct TextColorModel {
    let name:String
    let color:UIColor
}
class AddTextView: UIView {
    
    
    let kCONTENT_XIB_NAME = "AddTextView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var textFontCollView:UICollectionView!
    @IBOutlet var colorCollView:UICollectionView!
    var dismissViewAction:(()->Void)?
    var colorModels:[TextColorModel] = [TextColorModel(name: "", color: AppColors.redTextColor),
                                      TextColorModel(name: "", color: AppColors.orangeTextColor),
                                      TextColorModel(name: "", color: AppColors.yellowTextColor),
                                      TextColorModel(name: "", color: AppColors.greenTextColor),
                                      TextColorModel(name: "", color: AppColors.royalBlueTextColor),
                                      TextColorModel(name: "", color: AppColors.cyanTextColor),
                                      TextColorModel(name: "", color: AppColors.pinkTextColor),
                                      TextColorModel(name: "", color: AppColors.grayTextColor),
                                      TextColorModel(name: "", color: AppColors.whiteTextColor),
                                      TextColorModel(name: "", color: AppColors.lighGreenTextColor)]
   
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
        colorCollView.register(UINib(nibName: "AddTextColorCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
        textFontCollView.register(UINib(nibName: "AddTextFontCell", bundle: nil), forCellWithReuseIdentifier: "FontCell")
        contentView.fixInView(self)
        
    }
    //MARK: IBAction Methods
    @IBAction func dismissViewClicked() {
        if let action = dismissViewAction {
            action()
        }
    }
    //To rotate the screens and layout the views accordingly
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard
            let previousTraitCollection = previousTraitCollection,
            self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass ||
                self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass
            else {
                return
        }
    }
}


extension AddTextView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == textFontCollView {
            return 5
        }
        else {
            return colorModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == textFontCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontCell", for: indexPath) as! AddTextFontCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! AddTextColorCell
            let colorModel = self.colorModels[indexPath.row]
            cell.configure()
            cell.bgView.backgroundColor = colorModel.color
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == textFontCollView {
            return CGSize(width: 100, height: collectionView.bounds.height)
        }
        else {
            return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}


