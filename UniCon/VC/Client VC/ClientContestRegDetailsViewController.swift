//
//  ClientContestRegDetailsViewController.swift
//  UniCon
//
//  Created by Ricky on 8/30/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import AVKit

class ClientContestRegDetailsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tfBgView: UIView!
    @IBOutlet weak var detailBgView: UIView!
    @IBOutlet weak var addImgBgView: UIView!
    @IBOutlet weak var infoBgView: UIView!
    
    @IBOutlet weak var contestTitleTf: UITextField!
    @IBOutlet weak var imageCollView: UICollectionView!
    @IBOutlet weak var videoPlayerThumbnailImageView: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
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
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if  infoDescTv.text != "" && contestTitleTf.text != "" && images.count != 0 {
        createContestregRequest.content = infoDescTv.text
        createContestregRequest.title = contestTitleTf.text ?? ""
        let path1 = Bundle.main.path(forResource: "image1", ofType: "png")!
                let path2 = Bundle.main.path(forResource: "demo", ofType: "mp3")!
                let path3 = Bundle.main.path(forResource: "image1", ofType: "png")!
        createContestregRequest.guideVideUrl = path2
        createContestregRequest.guideVideThumbnailUrl = path1
        createContestregRequest.referenceImage = path3
        
       
        
        self.performSegue(withIdentifier: "ClientRegistrationConfirmationVC", sender: nil)
        }
        else {
            self.showAlertMessage(message: "Please Enter all fields")
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //MARK: Other View Setup
    override func viewWillLayoutSubviews() {
         self.scrollView.contentSize = CGSize(width: view.bounds.width, height: 680)
    }
    func viewSetup() {
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: 680)
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
        
        
        //Add gesture recognizer to view thumbnail
        addTapGestureToVideoThumb()
    }
    func addTapGestureToVideoThumb() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openVideoVC))
        videoPlayerThumbnailImageView.addGestureRecognizer(tapGesture)
    }
    //MARK: Navigating to other views
    func openPhotoPicker() {
        present(imgPicker!, animated: true, completion: nil)
    }
    //Display image viewer
    func openImageViewer(image:UIImage) {
        let imageVC = ImageViewerVC(nibName: "ImageViewerVC", bundle: nil)
        imageVC.image = image
        present(imageVC, animated: true, completion: nil)
    }
    @objc func openVideoVC() {
        //Demo URL
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if images.count > indexPath.row {
            let image = images[indexPath.row]
            openImageViewer(image: UIImage(named: image)!)
        }
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
