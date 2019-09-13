//
//  VideoRecordingVC.swift
//  UniCon
//
//  Created by Ricky on 8/26/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class VideoRecordingVC: UIViewController {
    //Recording status of the video
    fileprivate enum RecStatus {
        case notStartedRecording, recording, stopped, saved
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var videoContainerView:UIView!
    @IBOutlet weak var videoEditButtons:UIStackView!
    @IBOutlet weak var videoSaveButtons:UIStackView!
    @IBOutlet weak var galleryView:UIImageView!
    @IBOutlet weak var recordBtn:UIButton!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var nextButton:UIButton!
    
    //Other Declarations
    fileprivate var recordingStatus:RecStatus = .notStartedRecording
    fileprivate var filterPopupView:FilterPopupView?
    fileprivate var timerSettingScreenPopupView:TimerSettingScreen?
    fileprivate var musicEditingPopupView:MusicEditingPopupView?
    fileprivate var stickerPopupView:AddStickersPopupView?
    fileprivate var textPopupView:AddTextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        // Do any additional setup after loading the view.
    }
    
    func viewSetup() {
        nextButton.addCornerRadius(radius: 10)
        updateButtons()
        addTapGestureToGalleryImgv()
    }
    
    //MARK: Buttons/View Updates
    func updateButtons() {
        
        //View update according to the status of the app
        switch recordingStatus {
            
        case .notStartedRecording:
            nextButton.isHidden = true
            videoSaveButtons.isHidden = true
            videoEditButtons.isHidden = false
            galleryView.isHidden = false
            backButton.isHidden = false
            recordBtn.isHidden = false
            recordBtn.setImage(UIImage(named: "btnVideoStart"), for: .normal)
            
        case .recording:
            nextButton.isHidden = true
            videoSaveButtons.isHidden = true
            videoEditButtons.isHidden = true
            galleryView.isHidden = true
            backButton.isHidden = true
            recordBtn.isHidden = false
            recordBtn.setImage(UIImage(named: "btnVideoStop"), for: .normal)
          
        case .stopped:
            nextButton.isHidden = true
            videoSaveButtons.isHidden = false
            videoEditButtons.isHidden = false
            galleryView.isHidden = true
            backButton.isHidden = true
            recordBtn.isHidden = false
            recordBtn.setImage(UIImage(named: "btnVideoStart"), for: .normal)
            
        case .saved:
            nextButton.isHidden = false
            videoSaveButtons.isHidden = true
            videoEditButtons.isHidden = false
            galleryView.isHidden = true
            backButton.isHidden = false
            recordBtn.isHidden = true
            recordBtn.setImage(UIImage(named: "btnVideoStart"), for: .normal)
        }
    }
    func hideAllBtns() {
        nextButton.isHidden = true
        videoSaveButtons.isHidden = true
        videoEditButtons.isHidden = true
        galleryView.isHidden = true
        backButton.isHidden = false
        recordBtn.isHidden = true
    }
    //MARK: IBActions
    @IBAction func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextButtonClicked() {
        self.performSegue(withIdentifier: "UploadVideo", sender: nil)
    }
    @IBAction func addMusicClicked() {
        self.performSegue(withIdentifier: "AddMusic", sender: nil)
    }
    @IBAction func addFilterClicked() {
        showFilterPopupView()
    }
    @IBAction func startTimerClicked() {
        showTimerScreenPopupView()
    }
    @IBAction func editMusicClicked() {
        showMusicEditingPopupView()
    }
    @IBAction func addStickersClicked() {
        showStickerPopupView()
    }
    @IBAction func addTextViewClicked() {
        showAddTextView()
    }
    //MARK: Video Recording IBActions
    @IBAction func recordVideoClicked() {
        if recordingStatus == .notStartedRecording {
            recordingStatus = .recording
        }
        else {
            recordingStatus = .stopped
        }
        updateButtons()
    }
    @IBAction func deleteVideoClicked(){
        recordingStatus = .notStartedRecording
        updateButtons()
    }
    @IBAction func saveVideoClicked(){
        recordingStatus = .saved
        updateButtons()
    }
    
    //MARK: Video Picker from the gallery
//    func addTapGestureToGalleryImgv() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openVideoGalleryClicked))
//        galleryView.addGestureRecognizer(tapGesture)
//    }
//    @objc func openVideoGalleryClicked() {
//        showvideoPicker()
//    }
//    func showvideoPicker() {
//        let videoPickerController = UIImagePickerController()
//        videoPickerController.sourceType = .photoLibrary
//        videoPickerController.mediaTypes = ["kUTTypeMovie"]
//        videoPickerController.delegate = self
//        self.present(videoPickerController, animated: true, completion: nil)
//    }
    //MARK: Filter Pop Up View
    func showFilterPopupView() {
        if filterPopupView == nil {
            filterPopupView = FilterPopupView(frame: CGRect(x: 0, y: 0, width: self.view.viewWidth(), height: self.view.viewHeight()))
            filterPopupView?.dismissViewAction = {
                self.hideFilterPopupView()
            }
            filterPopupView?.saveFilterAction = {
                self.hideFilterPopupView()
            }
            filterPopupView?.shareCollView.reloadData()
            self.view.addSubview(filterPopupView!)
            hideAllBtns()
        }
    }
    func hideFilterPopupView() {
        filterPopupView?.removeFromSuperview()
        filterPopupView = nil
        updateButtons()
    }
    //MARK: Timer Setting Screen Popup View
    func showTimerScreenPopupView() {
        if timerSettingScreenPopupView == nil {
            timerSettingScreenPopupView = TimerSettingScreen(frame: CGRect(x: 0, y: 0, width: self.view.viewWidth(), height: self.view.viewHeight()))
            timerSettingScreenPopupView?.startTimerAction = {
                self.hideTimerScreenPopupView()
            }
            self.view.addSubview(timerSettingScreenPopupView!)
            hideAllBtns()
        }
    }
    func hideTimerScreenPopupView() {
        timerSettingScreenPopupView?.removeFromSuperview()
        timerSettingScreenPopupView = nil
        updateButtons()
    }
    //MARK: Timer Setting Screen Popup View
    func showMusicEditingPopupView() {
        if musicEditingPopupView == nil {
            musicEditingPopupView = MusicEditingPopupView(frame: CGRect(x: 0, y: 0, width: self.view.viewWidth(), height: self.view.viewHeight()))
            musicEditingPopupView?.selectedAction = {
                self.hideMusicEditingPopupView()
            }
            self.view.addSubview(musicEditingPopupView!)
            hideAllBtns()
        }
    }
    func hideMusicEditingPopupView() {
        musicEditingPopupView?.removeFromSuperview()
        musicEditingPopupView = nil
        updateButtons()
    }
    //MARK: Stickers Screen Popup View
    func showStickerPopupView() {
        if stickerPopupView == nil {
            stickerPopupView =  AddStickersPopupView(frame: CGRect(x: 0, y: 0, width: self.view.viewWidth(), height: self.view.viewHeight()))
            stickerPopupView?.dismissViewAction = {
                self.hideStickerPopUpView()
            }
            self.view.addSubview(stickerPopupView!)
            hideAllBtns()
        }
    }
    func hideStickerPopUpView() {
        stickerPopupView?.removeFromSuperview()
        stickerPopupView = nil
        updateButtons()
    }
    //MARK: Add Text View
    func showAddTextView() {
        if textPopupView == nil {
            textPopupView = AddTextView(frame: CGRect(x: 0, y: 0, width: self.view.viewWidth(), height: self.view.viewHeight()))
            textPopupView?.dismissViewAction = {
                self.hideAddTextView()
            }
            self.view.addSubview(textPopupView!)
            hideAllBtns()
        }
    }
    //MARK: Hide Text View
    func hideAddTextView() {
        textPopupView?.removeFromSuperview()
        textPopupView = nil
        updateButtons()
    }
    
}


extension VideoRecordingVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] {
            print(videoURL)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
