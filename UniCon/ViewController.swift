//
//  ViewController.swift
//  UniCon
//
//  Created by Ricky on 8/20/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets Declaration
    @IBOutlet weak var numberOfParticipantsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        
        //Other Setup View
        setupView()
        // Do any additional setup after loading the view.
    }
    

    func setupView()
    {
        let attributedString = NSMutableAttributedString(string: "현재 10,000,000명이\n콘테스트 영상을 공유중입니다.", attributes: [
            .font: UIFont(name: "NotoSansCJKkr-Regular", size: 16.0)!,
            .foregroundColor: UIColor.white
            ])
        attributedString.addAttributes([
            .font: UIFont(name: "NotoSansCJKkr-Bold", size: 32.0)!,
            .foregroundColor: AppColors.default_red_color
            ], range: NSRange(location: 3, length: 11))
        
        numberOfParticipantsLabel.attributedText = attributedString
    }

}
