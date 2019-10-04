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
    
    //MARK: Constants
    private let MAX_DURATION = AppConsts.MAX_LENGTH_VIDEO
    private let MIN_DURATION = AppConsts.MIN_LENGTH_VIDEo
    
    //MARK: IBOutlets
    @IBOutlet weak var videoRangeSlider:ABVideoRangeSlider!
    @IBOutlet weak var durationLabel:UILabel!
    @IBOutlet weak var videoPlayerContainerView:UIView!
    @IBOutlet weak var saveBtn:UIButton!
    
    //Video URL passed from the called view controller
    var videoURL:NSURL?
    
    
    //File Private Variables
    fileprivate var player:AVPlayer!
    fileprivate var startTime:Float64 = 0
    fileprivate var endTime:Float64 = 0
    
    var timeObserver:Any!
    
    var trimmedVideoURL:((URL)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Setup View
        setupView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        player.pause()
        player.removeTimeObserver(self.timeObserver!)
        player.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        player.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        player.replaceCurrentItem(with: nil)
        player = nil
    }
    func setupView() {
        
        if let nsurl = videoURL{
            let url = nsurl as URL
            videoRangeSlider.setVideoURL(videoURL: url)
            playVideo(url: url)
        }
        videoRangeSlider.delegate = self
        videoRangeSlider.minSpace = Float(MIN_DURATION)
        videoRangeSlider.maxSpace = Float(MAX_DURATION)
        videoRangeSlider.setStartPosition(seconds: 0)
        saveBtn.addCornerRadius(radius: 2)
    }
    
    //MARK: Video Play & Setup Methods
    func playVideo(url:URL) {
        
        //Videoplayer initialised with the URL
        player = AVPlayer(url: url)
        
        //Setup of the player controller to play & control the video
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        playerController.showsPlaybackControls = false
        self.addChild(playerController)
        
        
        // Add your view Frame
        playerController.view.frame = self.videoPlayerContainerView.frame
        
        // Add sub view in your view
        self.videoPlayerContainerView.addSubview(playerController.view)
        
        // Add obseerver for the player to reply the video when video reaches the end
        self.timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (time) in
            if self.player.currentTime() > self.endTime.cmtime() {
                self.player.seek(to: 0.0.cmtime())
                // self.videoRangeSlider.progressPercentage =
            }
        }
        player.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old,.new], context: nil)
        player.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old,.new], context: nil)
        player.play()
    }
    func setEndTimeForPlayer() {
        
        if let playerItem = player.currentItem, playerItem.status == AVPlayerItem.Status.readyToPlay {
            let duration = playerItem.duration
            if duration < MAX_DURATION.cmtime() {
                self.endTime = duration.seconds
            }
            else {
                self.endTime = MAX_DURATION
            }
            let stringifyDuration = String(format: "%.2fs", duration.seconds)
            durationLabel.text = stringifyDuration
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status), let statusNumber = change?[.newKey] as? NSNumber {
            switch statusNumber.intValue {
            case AVPlayerItem.Status.readyToPlay.rawValue:
                setEndTimeForPlayer()
            default:
                print(statusNumber.intValue)
            }
        }
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
            
            cropVideo(url: videoURL!, statTime: Float(self.startTime), endTime: Float(self.endTime))
            vc.popViewController(animated: true)
        }
        else  {
            cropVideo(url: videoURL!, statTime: Float(self.startTime), endTime: Float(self.endTime))
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Other Helper Methods
  
   
    //MARK: Video Edit & Save
    func cropVideo(url: NSURL, statTime:Float, endTime:Float)
    {
        let manager = FileManager.default
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        let mediaType = "mp4"
        if mediaType == "kUTTypeMovie" || mediaType == "mp4" {
            let asset = AVAsset(url: url as URL)
            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
            print("video length: \(length) seconds")
            
            let start = statTime
            let end = endTime
            
            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                let name = "pickedInternalVideo"
                outputURL = outputURL.appendingPathComponent("\(name).mp4")
            }catch let error {
                print(error)
            }
            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.mp4
            
            let startTime = CMTime(seconds: Double(start), preferredTimescale: 1000)
            let endTime = CMTime(seconds: Double(end), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTime, end: endTime)
            
            exportSession.timeRange = timeRange
            exportSession.exportAsynchronously{
                switch exportSession.status {
                case .completed:
                    print("exported at \(outputURL)")
                    if let action = self.trimmedVideoURL {
                        action(outputURL)
                    }
                case .failed:
                    print("failed \(String(describing: exportSession.error))")
                    
                case .cancelled:
                    print("cancelled \(String(describing: exportSession.error))")
                    
                default: break
                }
            }
        }
    }
}

extension VideoLibraryEditVC:ABVideoRangeSliderDelegate {
    func didChangeValue(videoRangeSlider: ABVideoRangeSlider, startTime: Float64, endTime: Float64) {
        let duration = endTime - startTime
        self.startTime = startTime
        self.endTime = endTime
        let stringifyDuration = String(format: "%.2fs", duration)
        durationLabel.text = stringifyDuration
    }
    
    func indicatorDidChangePosition(videoRangeSlider: ABVideoRangeSlider, position: Float64) {
        player.seek(to: position.cmtime(), toleranceBefore: startTime.cmtime(), toleranceAfter: endTime.cmtime())
        
    }
}


extension VideoLibraryEditVC:AVPlayerViewControllerDelegate {
    
}
