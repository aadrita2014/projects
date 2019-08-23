//
//  ContestDetailListViewController.swift
//  UniCon
//
//  Created by Ricky on 8/23/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestDetailListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var contestListTv:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlackBackgroundColor()
        // Do any additional setup after loading the view.
        contestListTv.register(UINib(nibName: "ContestDetailListCell", bundle: nil), forCellReuseIdentifier: "ContestCell")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: IBAction Methods
    @IBAction func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterListClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCell", for: indexPath) as! ContestDetailListCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
