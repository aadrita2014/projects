//
//  ContestRegistrationDepositInfoVC.swift
//  UniCon
//
//  Created by Ricky on 8/31/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestRegistrationDepositInfoVC: UIViewController {

    @IBOutlet var totalAmount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add black background color
        totalAmount.text = createContestregRequest.totalPrize + "원"
        self.view.addBlackBackgroundColor()
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
    
}
}
