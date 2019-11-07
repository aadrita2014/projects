//
//  MyProfileVC.swift
//  UniCon
//
//  Created by Ricky on 11/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    @IBOutlet weak var uploadsCollView:UICollectionView!
    @IBOutlet weak var bookmarksTableView:UITableView!
    
    var bookmarks:[String] = []
    var uploadedVideos: [String] = []
    
    var showUploads:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addDefaultBackgroundColor()
        //collection and table view register
        reigisterNibs()
        //Setup the segment view according to the design
        segmentViewSetup()
        //Select the default value of segmented Control
        segmentValueChanged()
    }
    
    //MARK: View Setup
    func segmentViewSetup() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    }
    func reigisterNibs() {
        uploadsCollView.register(UINib(nibName: "UploadedVideosCell", bundle: nil), forCellWithReuseIdentifier: "UploadedVideosCell")
        bookmarksTableView.register(UINib(nibName: "BookmarksCell", bundle: nil), forCellReuseIdentifier: "BookmarksCell")
    }
    //MARK: IBActions Defined
    @IBAction func segmentValueChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            showUploadedVideos()
        }
        else {
            showBookmarks()
        }
    }
    
    func showUploadedVideos() {
        showUploads = true
        uploadsCollView.reloadData()
        uploadsCollView.isHidden = false
        bookmarksTableView.isHidden = true
    }
    func showBookmarks() {
        showUploads = false
        bookmarksTableView.reloadData()
        bookmarksTableView.isHidden = false
        uploadsCollView.isHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MyProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedVideosCell", for: indexPath) as! UploadedVideosCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.viewWidth()/3 - 20, height: 200)
    }
}

extension MyProfileVC:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarksCell", for: indexPath) as! BookmarksCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
