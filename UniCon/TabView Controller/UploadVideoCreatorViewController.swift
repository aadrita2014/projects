//
//  UploadVideoCreatorViewController.swift
//  UniCon
//
//  Created by Ricky on 8/27/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//To be inherited for other classes
class MusicInfo {
    let image,title,artistInfo,duration:String
    
    init(image:String,title:String,artistInfo:String,duration:String) {
        self.image = image
        self.title = title
        self.artistInfo = artistInfo
        self.duration = duration
    }
}

class UploadVideoCreatorViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var videoInfoTv: UITableView!
    @IBOutlet weak var uploadVideoBtn:UIButton!
    
    @IBOutlet weak var videoMetaInfoText: UITextView!
    @IBOutlet weak var videoInfoBackgroundView: UIView!
    @IBOutlet weak var infoTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentAllowedView: UIView!
    
    //MARK: Other Declarations
    var musicInfo:[MusicInfo] = []
    var showContestDetails:Bool = true
    
    
    var selectedContests:[ContestModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlackBackgroundColor()
        // Do any additional setup after loading the view.
        viewSetup()
    }
  
    //MARK: View Setup
    func segmentViewSetup() {
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        //Select the index by default that is general
        segmentControl.selectedSegmentIndex = 1
    }
    //Other view setup code
    fileprivate func infoTableSetup() {
        videoInfoTv.estimatedRowHeight = 0
        videoInfoTv.tableFooterView = UIView(frame: .zero)
        videoInfoTv.register(UINib(nibName: "ContestDetailListCell", bundle: nil), forCellReuseIdentifier: "ContestCell")
        videoInfoTv.register(UINib(nibName: "MusicInfoCell", bundle: nil), forCellReuseIdentifier: "MusicInfoCell")
    }
    func viewSetup() {
        uploadVideoBtn.addCornerRadius(radius: 5)
        segmentViewSetup()
        videoInfoBackgroundView.addCornerRadius(radius: 5)
        videoMetaInfoText.addCornerRadius(radius: 2)
        videoMetaInfoText.addBorderColor()
        videoInfoBackgroundView.addDarkGrayBackgroundColor()
        commentAllowedView.addCornerRadius()
        commentAllowedView.addDarkGrayBackgroundColor()
        infoTableSetup()
        reloadTable()
    }
    func reloadTable() {
        videoInfoTv.reloadData()
        infoTableHeightConstraint.constant = videoInfoTv.contentSize.height
    }
    
    //MARK: IBActions
    @IBAction func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentValueChanged() {
        showContestDetails = !showContestDetails
        videoInfoTv.reloadData()
        reloadTable()
        //If no contest is selected then move to select contest screen
        if showContestDetails {
            self.performSegue(withIdentifier: "SelectContest", sender: nil)
        }
    }
    @IBAction func uploadVideoClicked() {
        
    }
}

extension UploadVideoCreatorViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if showContestDetails {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showContestDetails{
            if section == 0 {
                return 1
            }
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showContestDetails{
            if indexPath.section == 0 {
                let contestCell = tableView.dequeueReusableCell(withIdentifier: "ContestCell", for: indexPath) as! ContestDetailListCell
                return contestCell
            }
        }
        let musicCell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoCell", for: indexPath) as! MusicInfoCell
        return musicCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showContestDetails{
            if indexPath.section == 0 {
                return 140
            }
        }
        return 110
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if showContestDetails{
            if section == 0 {
                return 0
            }
        }
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if showContestDetails {
            if section == 0{
                return nil
            }
        }
        let view = UIView(frame: CGRect(x: 8, y: 0, width: tableView.bounds.width, height: 30))
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: 12.0)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        titleLabel.text = "*음악 변경은 이전 화면에서 변경가능합니다."
        return view
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 8, y: 0, width: tableView.bounds.width, height: 30))
        view.addDarkGrayBackgroundColor()
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16.0)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        if showContestDetails {
            if section == 0 {
                titleLabel.text = "콘테스트 정보"
            }
            else {
                titleLabel.text = "음악 정보"
            }
        }
        else {
            titleLabel.text = "음악 정보"
        }
        return view
    }
}
