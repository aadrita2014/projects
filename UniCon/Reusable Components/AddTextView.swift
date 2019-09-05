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
struct TextModel {
    let name:String
}
class AddTextView: UIView {
    
    
    let kCONTENT_XIB_NAME = "AddTextView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var textFontCollView:UICollectionView!
    @IBOutlet var colorCollView:UICollectionView!
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
            return 5
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == textFontCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontCell", for: indexPath) as! AddTextFontCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! AddTextColorCell
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == textFontCollView {
            return CGSize(width: 100, height: 100)
        }
        else {
            return CGSize(width: 50, height: 50)
        }
       // return CGSize(width: collectionView.viewWidth()/4 - 10 , height: collectionView.viewHeight()/4 - 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}


