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
    let color:[CGColor]
}
class FilterPopupView: UIView {
    
   
    let kCONTENT_XIB_NAME = "FilterPopupView"
    
    //MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var shareCollView: UICollectionView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var filterContainerView:GradientView!
    @IBOutlet weak var selectedFilterLabel: UILabel!
    
    var selectedIndexPath:IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK: Actions to pass data to the parent view
    var dismissViewAction:(()->Void)?
    var saveFilterAction:((FilterModel)->Void)?
    
    //Demo filters
    var filterModels = [
        FilterModel(image: "filterRedwine", name: "PinkFlu",color:AppColors.pinkFlueGradient),
        FilterModel(image: "filterRedwine", name: "Whi",color:AppColors.whiteGradient),
        FilterModel(image: "filterRedwine", name: "Blues",color:AppColors.bluesGradient),
        FilterModel(image: "filterRedwine", name: "Mandarin",color:AppColors.mandarinGradient),
        FilterModel(image: "filterRedwine", name: "GreenTea",color:AppColors.greenTeaGradient),
        FilterModel(image: "filterRedwine", name: "Red Wine",color:AppColors.redWineGradient)
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
            action(self.filterModels[selectedIndexPath.row])
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
        self.shareCollView.collectionViewLayout.invalidateLayout()
        self.shareCollView.reloadData()
    }
}

//MARK: Collection View Delegate Methods
extension FilterPopupView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterPopupCell", for: indexPath) as! FilterPopupCell
        let socialModel = filterModels[indexPath.row]
        cell.configure()
        cell.setModel(model:socialModel)
        if indexPath == selectedIndexPath {
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
        let socialModel = filterModels[indexPath.row]
        selectedFilterLabel.text = socialModel.name
        selectedIndexPath = indexPath
        collectionView.reloadData()
        self.filterContainerView.gradientColor = self.filterModels[indexPath.row].color
    }
    
}






