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
    
    //Other Declaration
    fileprivate var recordingStatus:RecStatus = .notStartedRecording
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        // Do any additional setup after loading the view.
    }
    
    func viewSetup() {
        nextButton.addCornerRadius(radius: 10)
        updateButtons()
    }
    
    //MARK: Buttons/View Updates
    func updateButtons() {
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
    
    //MARK: IBActions
    @IBAction func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
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
    @IBAction func nextButtonClicked() {
        self.performSegue(withIdentifier: "UploadVideo", sender: nil)
    }
}
