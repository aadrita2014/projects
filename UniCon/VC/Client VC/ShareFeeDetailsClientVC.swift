//
//  ViewController.swift
//  UniCon
//
//  Created by Ricky on 8/20/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ShareFeeDetailsClientVC: UIViewController {

    //MARK: IBOutlets Declaration
    @IBOutlet weak var numberOfParticipantsLabel: UILabel!
    @IBOutlet weak var bgView1: UIView!
    @IBOutlet weak var bgView2: UIView!
    @IBOutlet weak var bgView3: UIView!
    
    @IBOutlet weak var shareChargeBtn: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    
    @IBOutlet weak var currentShareFeeTf: UITextField!
    @IBOutlet weak var costPerShareTf: UITextField!
    @IBOutlet weak var shareCostExhaustAmtTf: UITextField!
    
    //MARK: Overriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Default Background Color to the view
        self.view.addBlackBackgroundColor()
        
        //Other Setup View
        setupView()
        
    }
    func setupView()   {
        
        //To be used when API will be integrated
//        let attributedString = NSMutableAttributedString(string: "현재 10,000,000명이\n콘테스트 영상을 공유중입니다.", attributes: [
//            .font: UIFont(name: "NotoSansCJKkr-Regular", size: 16.0)!,
//            .foregroundColor: UIColor.white
//            ])
//        attributedString.addAttributes([
//            .font: UIFont(name: "NotoSansCJKkr-Bold", size: 32.0)!,
//            .foregroundColor: AppColors.default_red_color
//            ], range: NSRange(location: 3, length: 11))
//
//        numberOfParticipantsLabel.attributedText = attributedString
        
        //Background views setup
        bgView1.addDarkGrayBackgroundColor()
        bgView1.addCornerRadius()
        bgView2.addDarkGrayBackgroundColor()
        bgView2.addCornerRadius()
        bgView3.addDarkGrayBackgroundColor()
        bgView3.addCornerRadius()
        
        //Buttons setup
        shareChargeBtn.addCornerRadius()
        changeBtn.addCornerRadius()
        
        
        //Textfields setup
        currentShareFeeTf.updatePlaceHolder(text: "000", color: AppColors.default_red_color)
        currentShareFeeTf.addBottomBorder(color: UIColor.lightGray)
        
        costPerShareTf.updatePlaceHolder(text: "000", color: AppColors.default_red_color)
        costPerShareTf.addBottomBorder(color: UIColor.lightGray)
        
        shareCostExhaustAmtTf.updatePlaceHolder(text: "000", color: AppColors.default_red_color)
        shareCostExhaustAmtTf.addBottomBorder(color: AppColors.default_red_color)
        
    }

}
