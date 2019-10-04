//
//  ContestDetailListViewController.swift
//  UniCon
//
//  Created by Ricky on 8/23/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestDetailListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    //MARK: IBOutlets
    @IBOutlet weak var contestListTv:UITableView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    
    //To sort contests
    fileprivate var filterActionSheet:CustomActionSheet? = nil
    
    //From previous screen
    public var isToSelectContest:Bool = false
    
    var contestSelectedAction:((ContestModel)->Void)?
    
    //MARK: Overriden View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlackBackgroundColor()
        // Do any additional setup after loading the view.
        viewSetup()
    }
    //MARK: View Setup
    func viewSetup() {
        contestListTv.register(UINib(nibName: "ContestDetailListCell", bundle: nil), forCellReuseIdentifier: "ContestCell")
        if isToSelectContest {
            segmentedControl.isHidden = false
            segmentViewSetup()
        }
    }
    func segmentViewSetup() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
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
    //MARK: Shared Feed Popup Methods
    func showFilterActionSheet() {
        //To avoid the duplicate initialisation
        if filterActionSheet == nil {
            filterActionSheet = CustomActionSheet(frame: view.frame,title: "정렬")
            filterActionSheet?.addAction(title: "최신순", handler: { (action) in
                print("Action 1")
            })
            filterActionSheet?.addAction(title: "우승 확률 높은 순", handler: { (action) in
                print("Action 2")
            })
            filterActionSheet?.addAction(title: "우승 상금 많은 순", handler: { (action) in
                print("Action 3")
            })
            filterActionSheet?.dismissViewAction = { _ in
                self.removeFilterActionSheet()  
            }
            self.view.addSubview(filterActionSheet!)
            filterActionSheet?.reload()
        }
    }
    func removeFilterActionSheet() {
        if let actionSheet = filterActionSheet {
            actionSheet.removeFromSuperview()
            filterActionSheet = nil
        }
    }
}
