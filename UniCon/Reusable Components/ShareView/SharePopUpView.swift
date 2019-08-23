//
//  ShareGeneralView.swift
//  UniCon
//
//  Created by Ricky on 8/23/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class SharePopUpView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    struct ShareSocialMediaModel {
        let image, name:String
        var sharePrice:String?
        let isSocialPlatform:Bool
    }
    
    let kCONTENT_XIB_NAME = "SharePopUpView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var shareCollView: UICollectionView!
    
    
    var removeViewClicked:(()->Void)?
    var shareSuccessful:(()->Void)?
    var socialMediaModels = [
        ShareSocialMediaModel(image: "shareFacebook", name: "Facebook", sharePrice: "100",isSocialPlatform: true),
        ShareSocialMediaModel(image: "shareFacebook", name: "Instagram", sharePrice: "100",isSocialPlatform: true),
        ShareSocialMediaModel(image: "shareInstagramStory", name: "Story", sharePrice: "100",isSocialPlatform: true),
        ShareSocialMediaModel(image: "shareFacebook", name: "Twitter", sharePrice: "100",isSocialPlatform: true),
        ShareSocialMediaModel(image: "shareFacebook", name: "Band", sharePrice: "100",isSocialPlatform: true),
        ShareSocialMediaModel(image: "shareMore", name: "More", sharePrice: "100",isSocialPlatform: false),
        ShareSocialMediaModel(image: "shareReport", name: "Report", sharePrice: "100",isSocialPlatform: false)
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
        shareCollView.register(UINib(nibName: "SharePopUpCell", bundle: nil), forCellWithReuseIdentifier: "ShareCell")
        contentView.fixInView(self)
    }
    override func awakeFromNib() {
    }
    
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCell", for: indexPath) as! SharePopUpCell
        let socialModel = socialMediaModels[indexPath.row]
        cell.platformImage.image = UIImage(named: socialModel.image)
        cell.platformName.text = socialModel.name
        if socialModel.isSocialPlatform
        {
            if let price = socialModel.sharePrice
            {
                cell.priceLabel.text = "공유시"
                cell.sharePrice.text = "+\(price)원"
            }
        }
        else
        {
            cell.priceLabel.text = " "
            cell.sharePrice.text = " "
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let action = shareSuccessful {
            action()
        }
    }
    
    //MARK: IBAction Methods
    @IBAction func dismissView() {
        if let action = removeViewClicked {
            action()
        }
    }
    
    
}







