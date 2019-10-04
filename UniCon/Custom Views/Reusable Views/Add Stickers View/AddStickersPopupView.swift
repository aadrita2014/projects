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

struct EmojiModel {
    let emoji:String
}
class AddStickersPopupView: UIView {
    
    
    let kCONTENT_XIB_NAME = "AddStickersView"
    
    //MARK: Data storing variables
    var stickers:[UIImage] = []
    let emojiRanges = [
        0x1F601...0x1F64F, // emoticons
        //        0x1F600...0x1F636,  // Additional emoticons
        0x1F30D...0x1F567, // Other additional symbols
        0x1F680...0x1F6C0, // Transport and map symbols
        0x1F681...0x1F6C5 //Additional transport and map symbols
    ]
    var emojis: [String] = []
    var showEmojis:Bool = false
    
    //MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var stickersCollView: UICollectionView!
    @IBOutlet var segmentedControl:UISegmentedControl!
    
    var dismissViewAction:(()->Void)?
    var addStickerToTheView:((UIImage)->Void)?
    var addEmojiToTheView:((String,Double)->Void)?
    
    
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
        stickersCollView.register(UINib(nibName: "StickerCell", bundle: nil), forCellWithReuseIdentifier: "StickerCell")
        stickersCollView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCell")
        contentView.fixInView(self)
     
        if let layout = stickersCollView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        segmentViewSetup()
        //Add stickers to the array
        addStickers()
        //Add emojis to the array
        addEmojis()
    }
    //MARK: View Setup
    func segmentViewSetup() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    }
    //Add Demo Stickers from asset folder
    func addStickers() {
        for imageNo in 100...110 {
            if let img = UIImage(named: imageNo.description) {
                stickers.append(img)
            }
        }
    }
    //Add Emojis from defined unicode ranges
    func addEmojis() {
        for range in emojiRanges {
            for i in range {
                let c = String(describing: UnicodeScalar(i)!)
                emojis.append(c)
            }
        }
    }
    //MARK: IBAction Methods
    @IBAction func dismissViewClicked() {
        if let action = dismissViewAction {
            action()
        }
    }
    
    @IBAction func segmentValueChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            showEmojis = false
            if let layout = stickersCollView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            stickersCollView.isPagingEnabled = true
        }
        else {
            showEmojis = true
            if let layout = stickersCollView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
            stickersCollView.isPagingEnabled = false
        }
        self.stickersCollView.collectionViewLayout.invalidateLayout()
        self.stickersCollView.reloadData()
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
        self.stickersCollView.collectionViewLayout.invalidateLayout()
        self.stickersCollView.reloadData()
    }
}

//MARK: Collection View Delegates & Flow Layout Delegate
extension AddStickersPopupView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showEmojis {
            return emojis.count
        }
        return stickers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if showEmojis {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
            cell.emojiLabel.text = emojis[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
            let stickerImg = stickers[indexPath.row]
            cell.setImage(img: stickerImg)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if showEmojis {
            return CGSize(width: collectionView.viewWidth()/6, height: collectionView.viewWidth()/6)
        }
        return CGSize(width: collectionView.viewWidth()/3, height: collectionView.viewHeight()/4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if showEmojis {
            if let action = addEmojiToTheView {
                //let cell = collectionView.cellForItem(at: indexPath) as! EmojiCell
                let emoji = self.emojis[indexPath.row]
                action(emoji,50)
            }
        }
        else {
            if let action = addStickerToTheView {
                let image = self.stickers[indexPath.row]
                action(image)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

