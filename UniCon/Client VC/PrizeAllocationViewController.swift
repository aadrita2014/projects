//
//  PrizeAllocationViewController.swift
//  UniCon
//
//  Created by Ricky on 8/29/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class PrizeAllocationViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var changePriceBtn: UIButton!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var priceTf: UITextField!
    
    
    //MARK: Overriden view code
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //Add default background color to the view
        self.view.addBlackBackgroundColor()
        
        //Other view setup
        viewSetup()
        
    }
    
    //MARK: View Setup
    func viewSetup() {
        
        //Background view setup
        topBackgroundView.addCornerRadius(radius: 10)
        topBackgroundView.addDarkGrayBackgroundColor()
        
        bottomBackgroundView.addCornerRadius(radius: 10)
        bottomBackgroundView.addDarkGrayBackgroundColor()
        
        //Buttons Setup
        learnMoreButton.underline()
        changePriceBtn.addCornerRadius(radius: 2)
        
        //Textfield Setup
        priceTf.addBottomBorder(color: AppColors.default_red_color)
        priceTf.updatePlaceHolder(text: "1,000,0000", color: AppColors.default_red_color)
        
    }
    
    //MARK: IBActions
    @IBAction func changePriceClicked(){
        self.performSegue(withIdentifier: "ChangePrice", sender: nil)
    }
}
