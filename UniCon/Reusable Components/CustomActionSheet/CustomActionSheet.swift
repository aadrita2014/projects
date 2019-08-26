//
//  CustomActionSheet.swift
//  UniCon
//
//  Created by Ricky on 8/24/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class CustomActionSheet: UIView,UITableViewDelegate,UITableViewDataSource {
   
    
    typealias CompletionHandler = ((CustomActionSheet)->Void)?
    struct ActionModel {
        let title:String
        let handler:CompletionHandler?
    }
    private let kCONTENT_XIB_NAME = "CustomActionSheetView"
    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var dismissBtn:UIButton!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var actions:[ActionModel] = []
    var dismissViewAction:CompletionHandler = nil
    var tableTitle:String? = nil
    
    //MARK: View Setup Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    //Contents of a nib file are unarchived
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    init(frame: CGRect, title:String){
        super.init(frame: frame)
        self.tableTitle = title
        commonInit()
    }
    private func commonInit() {
        
        //Loading the view from the nib file
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        setupView()
    }
    func setupView() {
        tableView.register(UINib(nibName: "CustomActionSheetCell", bundle: nil), forCellReuseIdentifier: "ActionCell")
        tableView.estimatedRowHeight = 0
        tableView.addBlur()
        tableView.addCornerRadius(radius: 15)
        dismissBtn.addCornerRadius(radius: 5)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! CustomActionSheetCell
        cell.actionLabel.text = actions[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionHandler = actions[indexPath.row].handler
        if let action = actionHandler
        {
            dismissClicked()
            action?(self)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: 15.0)
        if let title = tableTitle {
           titleLabel.text = title
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        let separatorView = UIView(frame: CGRect(x: 0, y: 29, width: tableView.bounds.width, height: 0.3))
        separatorView.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(separatorView)
        return view
    }
    func addAction(title:String,handler:CompletionHandler) {
        let action = ActionModel(title: title, handler: handler)
        actions.append(action)
    }
    func reload() {
        tableView.reloadData()
        tableHeight.constant = tableView.contentSize.height
    }
    @IBAction func dismissClicked() {
        if let action = dismissViewAction
        {
            action(self)
        }
    }
}
