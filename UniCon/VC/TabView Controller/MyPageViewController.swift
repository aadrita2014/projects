//
//  MyPageViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    struct Menu {
        var title:String
        var segue:String
        var showDetail:Bool
    }
    @IBOutlet weak var tableView:UITableView!
      
    
    var options:[Menu] {
        get {
            if let user =  TokenManager.loggedInUser, user.role == Role.client.rawValue {
                
            }
            else {
                
            }
        }
    }
    
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

extension MyPageViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
}
