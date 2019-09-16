//
//  VideoRecordingVC.swift
//  UniCon
//
//  Created by Ricky on 8/26/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class VideoRecordingVC: UIViewController {
    //Recording status of the video
    fileprivate enum RecStatus {
        case notStartedRecording, recording, stopped, saved
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var videoContainerView:UIView!  //To preview the camera feed {
    @IBOutlet weak var videoEditButtons:UIStackView!
    @IBOutlet weak var videoSaveButtons:UIStackView!
    @IBOutlet weak var galleryView:UIImageView!
    @IBOutlet weak var recordBtn:UIButton!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var nextButton:UIButton!
    @IBOutlet weak var recordingProgress:UIProgressView!
    
    //MARK: Video Edit StackView IBOutlets
    @IBOutlet weak var selectMusicStackView:UIStackView!
    @IBOutlet weak var trimMusicStackView:UIStackView!
    @IBOutlet weak var addTextStackView:UIStackView!
    @IBOutlet weak var addStickerStackView:UIStackView!
    
    
    //Other Declarations
    fileprivate var recordingStatus:RecStatus = .notStartedRecording
    
    
    //Video Editing Functionality & Views
    fileprivate var filterPopupView:FilterPopupView?
    fileprivate var timerSettingScreenPopupView:TimerSettingScreen?
    fileprivate var musicEditingPopupView:MusicEditingPopupView?
    fileprivate var stickerPopupView:AddStickersPopupView?
    fileprivate var textPopupView:AddTextView?
    
    
    
    //MARK: Camera recording & saving declarations
    var captureDevice:AVCaptureDevice?
    var captureSession:AVCaptureSession?
    var videoInput:AVCaptureDeviceInput?
    var videoOutput:AVCaptureMovieFileOutput?
    var focusView:UIView?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var outputURL:URL?
    var recordingTimer:Timer?
    var totalElapsedSeconds:Double = 0.0
    var models:[TextColorModel] = []
    var snapGesture:[SnapGesture] = []
    //MARK: Other Variables
    var isMusicSelected:Bool = false {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: Overriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Nothing to add in here
        
    }
    override func viewWillLayoutSubviews() {
        //Nothing to add in here
    }
    override func viewDidAppear(_ animated: Bool) {
        //Initialising camera capture session and other variables after view appears to get the correct bounds of the view
        initialize()
    }
    func viewSetup() {
        nextButton.addCornerRadius(radius: 10)
        updateButtons()
        addTapGestureToGalleryImgv()
        updateUI()
    }
    
    func updateUI() {
        //track change in value of music selection variable and accordingly update the UI
        
        if isMusicSelected {
            videoEditButtons.insertSubview(trimMusicStackView, belowSubview: selectMusicStackView)
            trimMusicStackView.isHidden = false
        }
        else {
            videoEditButtons.removeArrangedSubview(trimMusicStackView)
            trimMusicStackView.isHidden = true
        }
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
            totalElapsedSeconds = 0.0
            toggleAddTextStickerViews()
            
        case .recording:
            startRecording()
            nextButton.isHidden = true
            videoSaveButtons.isHidden = true
            videoEditButtons.isHidden = true
            galleryView.isHidden = true
            backButton.isHidden = true
            recordBtn.isHidden = false
            recordBtn.setImage(UIImage(named: "btnVideoStop"), for: .normal)
            toggleAddTextStickerViews()
            
            
        case .stopped:
            stopRecording()
            nextButton.isHidden = true
            videoSaveButtons.isHidden = false
            videoEditButtons.isHidden = false
            galleryView.isHidden = true
            backButton.isHidden = true
            recordBtn.isHidden = false
            recordBtn.setImage(UIImage(named: "btnVideoStart"), for: .normal)
            recordingTimer?.invalidate()
            toggleAddTextStickerViews()
            
        case .saved:
            nextButton.isHidden = false
            videoSaveButtons.isHidden = true
            videoEditButtons.isHidden = false
            galleryView.isHidden = true
            backButton.isHidden = false
            recordBtn.isHidden = true
            recordBtn.setImage(UIImage(named: "btnVideoStart"), for: .normal)
            toggleAddTextStickerViews(show: true)
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
    func toggleAddTextStickerViews(show:Bool = false) {
        if show {
            
        }
        else {
//            videoEditButtons.removeArrangedSubview(addTextStackView)
//            videoEditButtons.removeArrangedSubview(addStickerStackView)
//            addTextStackView.isHidden = true
//            addStickerStackView.isHidden = true
        }
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
    //MARK: View Navigations Handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VideoLibraryEditVC {
            vc.videoURL = sender as? NSURL
            vc.trimmedVideoURL = { url in
                print(url)
            }
        }
    }
    //MARK: Video Picker from the gallery
    func addTapGestureToGalleryImgv() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openVideoGalleryClicked))
        galleryView.addGestureRecognizer(tapGesture)
    }
    @objc func openVideoGalleryClicked() {
        showvideoPicker()
    }
    func showvideoPicker() {
        let videoPickerController = UIImagePickerController()
        videoPickerController.sourceType = .photoLibrary
        videoPickerController.mediaTypes = ["public.movie"]
        videoPickerController.delegate = self
        self.present(videoPickerController, animated: true, completion: nil)
    }
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
           
            textPopupView?.addTextToParent = { model in
                self.models.append(model)
                self.addSnapView(textModel: model)
                self.hideAddTextView()
            }
            self.view.addSubview(textPopupView!)
            self.textPopupView?.textView.becomeFirstResponder()
            self.textPopupView?.textView.inputAccessoryView = self.textPopupView?.bottomContainerView
            
            hideAllBtns()
        }
    }
    //MARK: Hide Text View
    func hideAddTextView() {
        textPopupView?.removeFromSuperview()
        textPopupView = nil
        updateButtons()
    }
    
    func addSnapView(textModel:TextColorModel) {
        let snapView = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        snapView.text = textModel.name
        snapView.textColor = UIColor.white
        snapView.backgroundColor = textModel.color
        snapView.sizeToFit()
        snapView.center = videoContainerView.center
        
        snapGesture.append(SnapGesture(view: snapView))
        self.videoContainerView.addSubview(snapView)
     //   self.videoPreviewLayer?.addSublayer(snapView.layer)
    }
}
//MARK: UIImagePickerControllerDelegate
extension VideoRecordingVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] else {
            picker.dismiss(animated: true, completion: nil)
            return }
        picker.dismiss(animated: true) {
            self.performSegue(withIdentifier: "PickedVideoEdit", sender: videoURL)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: Video Recording & Setup Methods
extension VideoRecordingVC {
    //To get the temporary save path for the recorded video
    func getVideoOutputPath() -> URL? {
        let outputPath = NSTemporaryDirectory() + "output.mov" //Demo File Name
        let outputURL = URL(fileURLWithPath: outputPath)
        let fileManager = FileManager.default
        //Check if already exists and try to delete the file
        if fileManager.fileExists(atPath: outputPath) {
            do {
                try fileManager.removeItem(atPath: outputPath)
            }catch {
                print("Not able to remove the file")
                return nil
            }
        }
        return outputURL
    }
    func getAppDocumentsPath() {
        
    }
    func initialize() {
        //To avoid duplicating the capture session
        if captureSession != nil {
            return
        }
        //Initiate the capture session
        captureSession = AVCaptureSession()
        
        //Start capturing the camera feed by default from the back camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            self.captureDevice = device
            do {
                let inputDevice = try AVCaptureDeviceInput(device: device)
                captureSession?.addInput(inputDevice)
            }
            catch {
                showAlertMessage(title: "Error", message: "Camera initialisation Failed")
            }
            
            setVideoOutput(session: captureSession!)
            //Set the video layer to preview the live camera content
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = videoContainerView.layer.bounds
            videoContainerView.layer.addSublayer(videoPreviewLayer!)
            
            //Start capturing the session
            captureSession?.startRunning()
            
            checkForPermission()
        }
        else {
            //Method added to the extension of the view controller to show alert messages
            showAlertMessage(title: "Error", message: "Camera initialisation Failed")
        }
    }
    //Setup the video output and other related variables
    func setVideoOutput(session:AVCaptureSession) {
        //set the video output variable
        videoOutput = AVCaptureMovieFileOutput()
        
        let totalTime = AppConsts.MAX_LENGTH_VIDEO
        let timeScale:Int32 = 1 //FPS
        
        let max_duration_cmTime = totalTime.cmtime(timeScale: timeScale)
        videoOutput?.maxRecordedDuration = max_duration_cmTime
        //Set min free space in bytes for recording to continue on a volume
        videoOutput?.minFreeDiskSpaceLimit = 1024 * 1024
        
        if session.canAddOutput(videoOutput!) {
            session.addOutput(videoOutput!)
        }
    }
    //Start Recording
    func startRecording() {
        if let videoOutput = self.videoOutput, let outputURL = self.getVideoOutputPath() {
            videoOutput.startRecording(to: outputURL, recordingDelegate: self)
            if recordingTimer == nil {
                recordingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
            }
        }
    }
    func stopRecording() {
        if let videoOutput = self.videoOutput {
            videoOutput.stopRecording()
            totalElapsedSeconds = 0.0
        }
    }
    func saveRecordedVideo() {
        
    }
    //Check camera authorization
    func checkForPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if status == AVAuthorizationStatus.authorized {
            
            captureSession?.startRunning()
            
        } else if status == AVAuthorizationStatus.denied || status == AVAuthorizationStatus.restricted {
            
            captureSession?.stopRunning()
            showAlertMessage(title: "Error", message: "Please give camera capture permission")
        }
    }
    //To track the video progress
    @objc func startTimer() {
        totalElapsedSeconds = totalElapsedSeconds + 1.0
        //let progressMax = 1.0/AppConsts.MAX_LENGTH_VIDEO
        let currentProgress = totalElapsedSeconds/AppConsts.MAX_LENGTH_VIDEO
        recordingProgress.setProgress(Float(currentProgress), animated: true)
    }
}

extension VideoRecordingVC:AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("saved file \(outputFileURL)")
        if error == nil {
            self.outputURL = outputFileURL
        }
        else {
            showAlertMessage(title: "Error", message: "Failed to save the video")
        }
    }
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Recording Started at \(fileURL)")
    }
    
    
}
