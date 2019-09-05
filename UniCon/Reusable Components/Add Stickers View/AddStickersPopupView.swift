//
//  AddStickersPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct StickerModel {
    let image, name:String
}
class AddStickersPopupView: UIView {
    
    
    let kCONTENT_XIB_NAME = "AddStickersView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var stickerCollView: UICollectionView!
    
    var dismissViewAction:(()->Void)?
   
    var socialMediaModels = [
        StickerModel(image: "shareFacebook", name: "Facebook"),
        StickerModel(image: "shareFacebook", name: "Instagram"),
        StickerModel(image: "shareInstagramStory", name: "Story"),
        StickerModel(image: "shareFacebook", name: "Twitter"),
        StickerModel(image: "shareFacebook", name: "Band"),
        StickerModel(image: "shareMore", name: "More"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report"),
        StickerModel(image: "shareReport", name: "Report")
    ]
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
        stickerCollView.register(UINib(nibName: "StickerCell", bundle: nil), forCellWithReuseIdentifier: "StickerCell")
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
        
        self.stickerCollView.collectionViewLayout.invalidateLayout()
        self.stickerCollView.reloadData()
    }
}


extension AddStickersPopupView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        let socialModel = socialMediaModels[indexPath.row]
        
        cell.setModel(model:socialModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.viewWidth()/4 - 10 , height: collectionView.viewHeight()/4 - 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

