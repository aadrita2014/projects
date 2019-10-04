//
//  ContestDetailsClientVC.swift
//  UniCon
//
//  Created by Ricky on 8/28/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestDetailsClientVC: UIViewController {

    
    //MARK: IBOutlets
    @IBOutlet weak var participationCollView:UICollectionView!
    @IBOutlet weak var videoThumbnailImg: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var reportBtn: UIButton!
    @IBOutlet weak var shareFeeBtn: UIButton!
    @IBOutlet weak var judgingBtn: UIButton!
    @IBOutlet weak var deadlineBtn: UIButton!
    @IBOutlet weak var collViewHeaderView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add Default Background Color to the view
        self.view.addBlackBackgroundColor()
     
        //Setup View
        setupView()
        
    }
    override func viewWillLayoutSubviews() {
        participationCollView.reloadData()
    }
    
    //View setup
    func setupView() {
        
        videoThumbnailImg.addCornerRadius(radius: 2)
        imageView1.addCornerRadius()
        imageView2.addCornerRadius()
        imageView3.addCornerRadius()
        reportBtn.addCornerRadius()
        shareFeeBtn.addCornerRadius()
        judgingBtn.addCornerRadius()
        deadlineBtn.addCornerRadius()
        collViewHeaderView.addDarkGrayBackgroundColor()
        collViewHeaderView.addCornerRadius()
        
        participationCollView.frame.size = CGSize(width: participationCollView.frame.width, height: participationCollView.contentSize.height)
        participationCollView.register(UINib(nibName: "ParticipationCell", bundle: nil), forCellWithReuseIdentifier: "ParticipationCell")

    }
    //MARK: IBAction methods
    @IBAction func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK: Collection View Delegates
extension ContestDetailsClientVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipationCell", for: indexPath) as! ParticipationCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.viewWidth()/3 - 5, height: 200)
    }
}
