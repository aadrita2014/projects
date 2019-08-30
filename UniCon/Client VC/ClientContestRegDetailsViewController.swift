//
//  ClientContestRegDetailsViewController.swift
//  UniCon
//
//  Created by Ricky on 8/30/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ClientContestRegDetailsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tfBgView: UIView!
    @IBOutlet weak var detailBgView: UIView!
    @IBOutlet weak var addImgBgView: UIView!
    @IBOutlet weak var infoBgView: UIView!
    
    @IBOutlet weak var contestTitleTf: UITextField!
    @IBOutlet weak var imageCollView: UICollectionView!
    
    @IBOutlet weak var infoDescTv: UITextView!
    var images: [String] = ["demo_featured_creaor",
                               "demo_featured_creaor",
                               "demo_featured_creaor",
    ]
    //MARK: Overriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add default background color
        self.view.addBlackBackgroundColor()
        
        //Other view setup
        viewSetup()
    }
    
    //MARK: Other View Setup
    func viewSetup() {
        
        //Bakcground views setup
        tfBgView.addCornerRadius()
        tfBgView.addDarkGrayBackgroundColor()
        
        detailBgView.addCornerRadius()
        detailBgView.addDarkGrayBackgroundColor()
        
        addImgBgView.addCornerRadius()
        addImgBgView.addDarkGrayBackgroundColor()
        
        infoBgView.addCornerRadius()
        infoBgView.addDarkGrayBackgroundColor()
        
        //Text field setup
        contestTitleTf.updatePlaceHolder(text: "MBN 건강미 뽐내기 콘테스트", color: .white)
        contestTitleTf.addBottomBorder(color: AppColors.default_red_color)
        
        //Collection view setup
        imageCollView.register(UINib(nibName: "RefImageCell", bundle: nil), forCellWithReuseIdentifier: "RefImageCell")
        
        //Text view setup
        infoDescTv.addBorderColor(borderWidth: 1.0, color: UIColor.white)
        infoDescTv.addCornerRadius()
    }
}


extension ClientContestRegDetailsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RefImageCell", for: indexPath) as! RefImageCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.viewWidth()/6, height: collectionView.viewWidth()/6)
    }
}
