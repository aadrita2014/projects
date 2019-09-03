//
//  FilterPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/3/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

struct FilterModel {
    let image, name:String
}
class FilterPopupView: UIView {
    
   
    let kCONTENT_XIB_NAME = "FilterPopupView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var shareCollView: UICollectionView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var filterContainerView:UIView!
    @IBOutlet weak var selectedFilterLabel: UILabel!
    
    var selectedIndexPath:IndexPath?
    var dismissViewAction:(()->Void)?
    var saveFilterAction:(()->Void)?
    var socialMediaModels = [
        FilterModel(image: "shareFacebook", name: "Facebook"),
        FilterModel(image: "shareFacebook", name: "Instagram"),
        FilterModel(image: "shareInstagramStory", name: "Story"),
        FilterModel(image: "shareFacebook", name: "Twitter"),
        FilterModel(image: "shareFacebook", name: "Band"),
        FilterModel(image: "shareMore", name: "More"),
        FilterModel(image: "shareReport", name: "Report")
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
        shareCollView.register(UINib(nibName: "FilterPopupCell", bundle: nil), forCellWithReuseIdentifier: "FilterPopupCell")
        contentView.fixInView(self)
        saveBtn.addCornerRadius()
        
    }
    //MARK: IBAction Methods
    @IBAction func dismissViewClicked() {
        if let action = dismissViewAction {
            action()
        }
    }
    @IBAction func saveFilterClicked() {
        if let action = saveFilterAction {
            action()
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard
            let previousTraitCollection = previousTraitCollection,
            self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass ||
                self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass
            else {
                return
        }
        
        self.shareCollView.collectionViewLayout.invalidateLayout()
        self.shareCollView.reloadData()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        self.collectionView?.collectionViewLayout.invalidateLayout()
//
//        coordinator.animate(alongsideTransition: { context in
//
//        }, completion: { context in
//            self.collectionView?.collectionViewLayout.invalidateLayout()
//
//            self.collectionView?.visibleCells.forEach { cell in
//                guard let cell = cell as? Cell else {
//                    return
//                }
//                cell.setCircularImageView()
//            }
//        })
//    }
}
extension FilterPopupView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterPopupCell", for: indexPath) as! FilterPopupCell
        let socialModel = socialMediaModels[indexPath.row]
        cell.configure()
        cell.setModel(model:socialModel)
        if let index = selectedIndexPath, indexPath == index {
            cell.filterImage.addBorderColor(borderWidth: 2.0, color: AppColors.default_red_color)
        }
        else {
            cell.filterImage.addBorderColor(borderWidth: 0.0, color: AppColors.default_red_color)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let socialModel = socialMediaModels[indexPath.row]
        filterContainerView.addBlackBackgroundColor()
        selectedFilterLabel.text = socialModel.name
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
    
}






