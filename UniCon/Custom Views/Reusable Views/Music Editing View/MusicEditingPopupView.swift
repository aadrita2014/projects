//
//  MusicEditingPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import AVKit
class MusicEditingPopupView: UIView {

    let kCONTENT_XIB_NAME = "MusicEditingView"
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var musicInfoLabel:UILabel!
    @IBOutlet weak var saveTrimmedMusicButton:UIButton!
    @IBOutlet var waveformContainer:UIView!
    
    var waveformView:VIWaveformView!
    var selectedMusicModel:MusicInfo? {
        didSet {
           updateMusicLabel()
        }
    }
    var selectedAction:(()->Void)?
    
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
        contentView.fixInView(self)
        saveTrimmedMusicButton.addCornerRadius()
        setupWaveformView()
    }
    func updateMusicLabel() {
         musicInfoLabel.text = selectedMusicModel!.title + " - " + selectedMusicModel!.artistInfo
    }
    func setupWaveformView() {
        waveformView = VIWaveformView()
        waveformView.minWidth = waveformView.bounds.width
        waveformView.waveformNodeViewProvider = BasicWaveFormNodeProvider(generator: { () -> NodePresentation in
            let view = VIWaveformNodeView()
            view.waveformLayer.strokeColor = AppColors.default_red_color.cgColor
            return view
        }())
        waveformContainer.addSubview(waveformView)
        waveformView.translatesAutoresizingMaskIntoConstraints = false
        
        waveformView.leftAnchor.constraint(equalTo: waveformContainer.leftAnchor, constant: 15).isActive = true
        waveformView.rightAnchor.constraint(equalTo: waveformContainer.rightAnchor, constant: -15).isActive = true
        waveformView.centerYAnchor.constraint(equalTo: waveformContainer.centerYAnchor, constant: 0).isActive = true
        waveformView.heightAnchor.constraint(equalToConstant: waveformContainer.bounds.height).isActive = true
        
        waveformView.layoutIfNeeded()
        if let url = Bundle.main.url(forResource: "demo", withExtension: "mp3") {
            let asset = AVAsset.init(url: url)
            _ = waveformView.loadVoice(from: asset, completion: { (asset) in
            })
        }
    }
    @IBAction fileprivate func selectedClicked() {
        if let action = selectedAction {
            action()
        }
    }
}
