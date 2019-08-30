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
    var images: [String] = []
    
    var imgPicker:UIImagePickerController?
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
        
        //Async setup of the image controller
        DispatchQueue.main.async {
            self.imgPicker = UIImagePickerController()
            self.imgPicker?.sourceType = .savedPhotosAlbum
            self.imgPicker?.allowsEditing = false
            self.imgPicker?.delegate = self
        }
    }
    
    func openPhotoPicker() {
        present(imgPicker!, animated: true, completion: nil)
    }
}


extension ClientContestRegDetailsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MAX Images user can add
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RefImageCell", for: indexPath) as! RefImageCell
        
        //Custom actions defined in RegImageCell
        cell.addAction = { cell in
            self.openPhotoPicker()
        }
        cell.delAction = { cell in
            self.images.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        //If image is added then hide/show views in the collection view accordingly
        if images.count > indexPath.row {
            cell.refImage.image = UIImage(named: images[indexPath.row])
            cell.addImgBtn.isHidden = true
            cell.deletebtn.isHidden = false
        }
        else {
            cell.addImgBtn.isHidden = false
            cell.deletebtn.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.viewWidth()/6, height: collectionView.viewWidth()/6)
    }
}

extension ClientContestRegDetailsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        images.append("demo_featured_creator")
        imageCollView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
