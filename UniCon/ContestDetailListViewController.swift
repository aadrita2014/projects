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
        showFilterActionSheet()
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
    
    func showFilterActionSheet()
    {
        let actionSheet = UIAlertController(title: "정렬", message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.view.tintColor = UIColor.red  // change text color of the buttons
        actionSheet.view.backgroundColor = UIColor.black  // change background color
       
        
        let newestAction = UIAlertAction(title: "최신순", style: .default, handler: nil)
        let highWinningAction = UIAlertAction(title: "우승 확률 높은 순", style: .default, handler: nil)
        let netWinningPrizeAction = UIAlertAction(title: "우승 상금 많은 순", style: .default, handler: nil)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(newestAction)
        actionSheet.addAction(highWinningAction)
        actionSheet.addAction(netWinningPrizeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
