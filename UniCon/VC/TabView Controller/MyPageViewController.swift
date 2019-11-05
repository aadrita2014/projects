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
      
    
    var menuOptions:[Menu] {
        get {
            if let user =  TokenManager.loggedInUser, user.role == Role.client.rawValue {
                return clientMenu
            }
            else {
                return creatorMenu
            }
        }
    }
    
    var creatorMenu:[Menu] = [
        Menu(title: "개인정보 수정", segue: "EditPersonal", showDetail: true),
        Menu(title: "나의 상금",segue: "MyPrize",showDetail: true),
        Menu(title: "나의 뱃지", segue: "MyBadge", showDetail: true),
        Menu(title: "지원센터", segue: "SupportCenter", showDetail: true),
        Menu(title: "이용약관", segue: "TermsUse", showDetail: true),
        Menu(title: "개인정보 처리방침", segue: "PrivacyPolicy", showDetail: true),
        Menu(title: "유니콘 정보", segue: "UniconInfo", showDetail: true),
        Menu(title: "로그아웃", segue: "", showDetail: false)
    ]
    
    var clientMenu:[Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        // Do any additional setup after loading the view.
        viewSetup()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func viewSetup() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension MyPageViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        let detailIcon = cell.viewWithTag(2) as! UIImageView
        let menu = menuOptions[indexPath.row]
        label.text = menu.title
        detailIcon.isHidden = !menu.showDetail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menuOptions[indexPath.row]
        if !menu.segue.isEmpty {
           // self.performSegue(withIdentifier: menu.segue, sender: nil)
        }
        else {
            
        }
    }
    
    
}
