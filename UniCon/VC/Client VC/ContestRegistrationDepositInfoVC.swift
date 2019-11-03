//
//  ContestRegistrationDepositInfoVC.swift
//  UniCon
//
//  Created by Ricky on 8/31/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestRegistrationDepositInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add black background color
        self.view.addBlackBackgroundColor()
        
    }
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToCreateContest(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
