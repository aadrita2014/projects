//
//  VideoLibraryEditVC.swift
//  UniCon
//
//  Created by Ricky on 9/13/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoLibraryEditVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var videoRangeSlider:ABVideoRangeSlider!
    @IBOutlet weak var durationLabel:UILabel!
    @IBOutlet weak var videoPlayerContainerView:UIView!
    
    var videoURL:NSURL?
    var player = AVPlayer()
    var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Setup View
        setupView()
    }
    func setupView() {
        if let nsurl = videoURL{
            let url = nsurl as URL
            videoRangeSlider.setVideoURL(videoURL: url)
            playVideo(url: url)
        }
        videoRangeSlider.delegate = self
        videoRangeSlider.minSpace = 5.0
        videoRangeSlider.maxSpace = 60.0
        videoRangeSlider.setStartPosition(seconds: 0)
    }
    func playVideo(url:URL) {
    
        player = AVPlayer(url: url)
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        self.addChild(playerController)
        
        // Add your view Frame
        playerController.view.frame = self.videoPlayerContainerView.frame

        // Add sub view in your view
        self.videoPlayerContainerView.addSubview(playerController.view)
        player.play()
    }
    //MARK:IBActions
    @IBAction func backClicked() {
        if let vc = self.navigationController {
            vc.popViewController(animated: true)
        }
        else  {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func selectTrimmedVideo() {
        if let vc = self.navigationController {
            vc.popViewController(animated: true)
        }
        else  {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension VideoLibraryEditVC:ABVideoRangeSliderDelegate {
    func didChangeValue(videoRangeSlider: ABVideoRangeSlider, startTime: Float64, endTime: Float64) {
        let duration = endTime - startTime
        let stringifyDuration = String(format: "%.2fs", duration)
        durationLabel.text = stringifyDuration
    }
    
    func indicatorDidChangePosition(videoRangeSlider: ABVideoRangeSlider, position: Float64) {
        
    }
}


extension VideoLibraryEditVC:AVPlayerViewControllerDelegate {
    
}
