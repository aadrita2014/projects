//
//  ContestDepostiConfirmationVC.swift
//  UniCon
//
//  Created by Ricky on 8/30/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestDepostiConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add default black background color
        self.view.addBlackBackgroundColor()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
