//
//  GeneralVideosViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class GeneralVideosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
