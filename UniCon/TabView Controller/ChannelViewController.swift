//
//  ChannelViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    
    //MARK: IBOutlets Declarations
    @IBOutlet weak var searchTf:UITextField!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var topSliderView:UIScrollView!
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: Category Collection View Declarations
    var featuredCollViewLabel, referralCollViewLabel, ongoingContesCollViewLabel, contestJudgingCollViewLabel, contestClosedCollViewlabel:UILabel!
    
    var featuredCollView,referralCollView,ongoingContestCollView,contestJudgingCollView,contestClosedCollView:UICollectionView!
    
    var showMoreOngoing,showMoreContestJudging,showMoreContestClosed:UIButton!
    //MARK: Collection View Layout Declarations
    let featuredCollViewLayout = UICollectionViewFlowLayout()
    let referallClientViewLayout = UICollectionViewFlowLayout()
    let ongoingContestLayout = UICollectionViewFlowLayout()
    let contestJudgingLayout = UICollectionViewFlowLayout()
    let contestClosedLayout = UICollectionViewFlowLayout()
    
    //MARK: Client Controls
    var segmentedControl:UISegmentedControl!
    
    //MARK: Demo Images Declaration
    let images = ["demo_image",
                  "demo_image",
                  "demo_image",
                  "demo_image",
                  "demo_image"]
    
    let demo_featured_creator = ["demo_featured_creator",
                                 "demo_featured_creator_2"]
    let demo_referral_client = ["client_demo_1",
                                "client_demo_2",
                                "client_demo_3"]
    var test_btn_status = [false,false,false,false,false]
    var viewSetup = false
    
    //Margin for collection Views
    let const_top_margin = CGFloat(16)
    
    
    var isClient = Defaults.getBool(key: StringConsts.isClientSaveKey)
    //MARK: Inital Setup of the View
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        if viewSetup == false {
            setupView()
            viewSetup = true
        }
    }
    func setupView()
    {
        //Setup Top Slider
        setupTopSlider()
        //Update Search Placeholder
        searchTf.updatePlaceHolder(text: "검색")
        if isClient {
            addSegmentedControl(topSliderView)
            addAllForClient(value: 0)
        }
        else {
            addAllForCreators()
        }
        
    }
    func addAllForCreators() {
        //Add Featured Collection View Programmatically
        addFeaturedCategoryView(topSliderView)
        //Add Referral Client Collection View Programmatically
        addReferralClientCollView(featuredCollView)
        //Add Ongoing Collection View Programmatically
        addOngoingContestCollView(referralCollView)
        //Add Contest Judging Collection View Programmatically
        addJudgingContestCollView(ongoingContestCollView)
        //Add Closed Contest Collection View Programmatically
        addClosedContestCollView(contestJudgingCollView)
        updateLayout()
    }
    func addAllForClient(value:Int){
        
        removeFeaturedCategoryView()
        removeReferralCollView()
        removeOngoingCollView()
        removeContestJudgingCollView()
        removeClosedContestCollView()
        
        if value == 0 {
            //Add Ongoing Collection View Programmatically
            addOngoingContestCollView(segmentedControl)
            //Add Contest Judging Collection View Programmatically
            addJudgingContestCollView(ongoingContestCollView)
            //Add Closed Contest Collection View Programmatically
            addClosedContestCollView(contestJudgingCollView)
            //Adjust the container view height according to the content
        }
        else {
            //Add Featured Collection View Programmatically
            addFeaturedCategoryView(segmentedControl)
            //Add Referral Client Collection View Programmatically
            addReferralClientCollView(featuredCollView)
            //Add Ongoing Collection View Programmatically
            addOngoingContestCollView(referralCollView)
            //Add Contest Judging Collection View Programmatically
            addJudgingContestCollView(ongoingContestCollView)
            //Add Closed Contest Collection View Programmatically
            addClosedContestCollView(contestJudgingCollView)
        }
        updateLayout()
    }
    func updateLayout() {
       containerHeightConstraint.constant = contestClosedCollView.frame.origin.y + contestClosedCollView.frame.height + 20
    }
    
    //MARK: Textfield delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //MARK: Slider Setup
    func setupTopSlider() {
        var xOrigin = CGFloat(0)
        for (index,image) in images.enumerated() {
            let imageView = UIImageView(frame:  CGRect(x: xOrigin, y: 0, width: self.view.frame.width , height: self.topSliderView.bounds.height))
            imageView.image = UIImage(named: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            topSliderView.addSubview(imageView)
            xOrigin = self.view.frame.width * CGFloat(index + 1)
        }
        topSliderView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(images.count), height: topSliderView.bounds.height)
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        containerView.bringSubviewToFront(pageControl)
    }
    //MARK: ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == topSliderView {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }
        self.view.endEditing(true)
    }
    //MARK: Client Segment Control
    func addSegmentedControl(_ relativeView:UIView) {
        segmentedControl = UISegmentedControl(frame: CGRect(x: 70, y: relativeView.frame.origin.y + relativeView.frame.height + 8, width: self.view.viewWidth() - 140, height: 29))
        
        segmentedControl.tintColor = AppColors.default_red_color
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        segmentedControl.insertSegment(withTitle: "나의 콘테스트", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "전체 콘테스트", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        containerView.addSubview(segmentedControl)
    }
    @objc func segmentValueChanged() {
        addAllForClient(value: segmentedControl.selectedSegmentIndex)
    }
    
    //MARK: Collection View Initialisation & Label Initialisations
    func addFeaturedCategoryView(_ relativeView:UIView) {
        // Init & Setup Featured Category Label
        featuredCollViewLabel = UILabel(frame: CGRect(x: 8, y: relativeView.frame.origin.y + relativeView.frame.height + 8, width: self.view.viewWidth(), height: 30))
        featuredCollViewLabel.text = "추천 크리에이터"
        featuredCollViewLabel.textColor = UIColor.white
        
        //Init & Setup Featured Collection View
        featuredCollViewLayout.scrollDirection = .horizontal
        featuredCollView = UICollectionView(frame: CGRect(x: 8, y: featuredCollViewLabel.frame.origin.y + featuredCollViewLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout:   featuredCollViewLayout)
        featuredCollView.showsHorizontalScrollIndicator = false
        featuredCollView.register(UINib(nibName: "FeaturedCreatorCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCreatorCell")
        
        //Set the delegate to self
        featuredCollView.dataSource = self
        featuredCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(featuredCollViewLabel)
        containerView.addSubview(featuredCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        featuredCollView.reloadData()
    }
    func removeFeaturedCategoryView() {
        if featuredCollView != nil {
            featuredCollViewLabel.removeFromSuperview()
            featuredCollView.removeFromSuperview()
        }
    }
    func addReferralClientCollView(_ relativeView:UIView) {
        // Init & Setup Referral Client Category Label
        referralCollViewLabel = UILabel(frame: CGRect(x: 8, y: relativeView.frame.origin.y + relativeView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        referralCollViewLabel.text = "추천 클라이언트"
        referralCollViewLabel.textColor = UIColor.white
        
        //Init & Setup Referral Client Collection View
        referallClientViewLayout.scrollDirection = .horizontal
        referralCollView = UICollectionView(frame: CGRect(x: 8, y: referralCollViewLabel.frame.origin.y + referralCollViewLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/4), collectionViewLayout: referallClientViewLayout)
        referralCollView.register(UINib(nibName: "ReferralClientCell", bundle: nil), forCellWithReuseIdentifier: "ReferralClientCell")
        referralCollView.showsHorizontalScrollIndicator = false
        
        //Set the delegate to self
        referralCollView.dataSource = self
        referralCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(referralCollViewLabel)
        containerView.addSubview(referralCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        referralCollView.reloadData()
    }
    func removeReferralCollView() {
        if referralCollView != nil {
            referralCollViewLabel.removeFromSuperview()
            referralCollView.removeFromSuperview()
        }
    }
    func addOngoingContestCollView(_ relativeView:UIView) {
        // Init & Setup Ongoing Contest Category Label
        ongoingContesCollViewLabel = UILabel(frame: CGRect(x: 8, y: relativeView.frame.origin.y + relativeView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        ongoingContesCollViewLabel.text = "진행중 콘테스트"
        ongoingContesCollViewLabel.textColor = UIColor.white
        
        //Show More Button
        showMoreOngoing = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreOngoing.center.y = ongoingContesCollViewLabel.center.y
        showMoreOngoing.setImage(UIImage(named: "next_arrow"), for: .normal)
        showMoreOngoing.addTarget(self, action: #selector(ChannelViewController.showContestDetailList), for: .touchUpInside)
        
        //Init & Setup Ongoing Contest Collection View
        ongoingContestLayout.scrollDirection = .horizontal
        var collViewHeight = self.view.frame.height/2.5
        if collViewHeight < 250 { collViewHeight = 250 }
        ongoingContestCollView = UICollectionView(frame: CGRect(x: 8, y: ongoingContesCollViewLabel.frame.origin.y + ongoingContesCollViewLabel.frame.height + 8, width: self.view.frame.width, height: collViewHeight), collectionViewLayout: ongoingContestLayout)
        
        ongoingContestCollView.register(UINib(nibName: "OngoingContestCell", bundle: nil), forCellWithReuseIdentifier: "OngoingContestCell")
        ongoingContestCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        ongoingContestCollView.dataSource = self
        ongoingContestCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(ongoingContesCollViewLabel)
        containerView.addSubview(showMoreOngoing)
        containerView.addSubview(ongoingContestCollView)
        //Reload the Collection view to reload the data and size of the collection view
        ongoingContestCollView.reloadData()
    }
    func removeOngoingCollView() {
        if ongoingContestCollView != nil {
            ongoingContesCollViewLabel.removeFromSuperview()
            ongoingContestCollView.removeFromSuperview()
            showMoreOngoing.removeFromSuperview()
        }
    }
    func addJudgingContestCollView(_ relativeView:UIView) {
        // Init & Setup Judging Contest Category Label
        contestJudgingCollViewLabel = UILabel(frame: CGRect(x: 8, y: relativeView.frame.origin.y + relativeView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        contestJudgingCollViewLabel.text = "심사중 콘테스트"
        contestJudgingCollViewLabel.textColor = UIColor.white
        
        //Show More Button
        showMoreContestJudging = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreContestJudging.center.y = contestJudgingCollViewLabel.center.y
        showMoreContestJudging.setImage(UIImage(named: "next_arrow"), for: .normal)
        showMoreContestJudging.addTarget(self, action: #selector(ChannelViewController.showContestDetailList), for: .touchUpInside)
        
        // Init & Setup Judging Contest Category Label
        contestJudgingLayout.scrollDirection = .horizontal
        var collViewHeight = self.view.frame.height/2.5
        if collViewHeight < 250 { collViewHeight = 250 }
        contestJudgingCollView = UICollectionView(frame: CGRect(x: 8, y: contestJudgingCollViewLabel.frame.origin.y + contestJudgingCollViewLabel.frame.height + 8, width: self.view.frame.width, height: collViewHeight), collectionViewLayout: contestJudgingLayout)
        contestJudgingCollView.register(UINib(nibName: "ContestJudgingCell", bundle: nil), forCellWithReuseIdentifier: "ContestJudgingCell")
        contestJudgingCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        contestJudgingCollView.dataSource = self
        contestJudgingCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestJudgingCollViewLabel)
        containerView.addSubview(showMoreContestJudging)
        containerView.addSubview(contestJudgingCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestJudgingCollView.reloadData()
    }
    func removeContestJudgingCollView() {
        if contestJudgingCollView != nil {
            contestJudgingCollViewLabel.removeFromSuperview()
            contestJudgingCollView.removeFromSuperview()
            showMoreContestJudging.removeFromSuperview()
        }
    }
    func addClosedContestCollView(_ relativeView:UIView) {
        //Init & Setup Judging Contest Category Label
        contestClosedCollViewlabel = UILabel(frame: CGRect(x: 8, y: relativeView.frame.origin.y + relativeView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        contestClosedCollViewlabel.text = "종료된 콘테스트"
        contestClosedCollViewlabel.textColor = UIColor.white
        
        //Show More Button
        showMoreContestClosed = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreContestClosed.center.y = contestClosedCollViewlabel.center.y
        showMoreContestClosed.setImage(UIImage(named: "next_arrow"), for: .normal)
        showMoreContestClosed.addTarget(self, action: #selector(ChannelViewController.showContestDetailList), for: .touchUpInside)
        
        //Init & Setup Judging Contest Category Label
        contestClosedLayout.scrollDirection = .horizontal
        var collViewHeight = self.view.frame.height/2.5
        if collViewHeight < 250 { collViewHeight = 250 }
        contestClosedCollView = UICollectionView(frame: CGRect(x: 8, y: contestClosedCollViewlabel.frame.origin.y + contestClosedCollViewlabel.frame.height + 8, width: self.view.frame.width, height: collViewHeight), collectionViewLayout: contestClosedLayout)
        contestClosedCollView.register(UINib(nibName: "ContestClosedCell", bundle: nil), forCellWithReuseIdentifier: "ContestClosedCell")
        contestClosedCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        contestClosedCollView.dataSource = self
        contestClosedCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestClosedCollViewlabel)
        containerView.addSubview(showMoreContestClosed)
        containerView.addSubview(contestClosedCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestClosedCollView.reloadData()
    }
    func removeClosedContestCollView() {
        if contestClosedCollView != nil {
            contestClosedCollViewlabel.removeFromSuperview()
            contestClosedCollView.removeFromSuperview()
        }
    }
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCreatorCell", for: indexPath) as! FeaturedCreatorCell
            cell.creatorProfilePic.image = UIImage(named:demo_featured_creator[indexPath.row % 2])
            return cell
        }
        else if collectionView == referralCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReferralClientCell", for: indexPath) as! ReferralClientCell
            cell.clientLogo.image = UIImage(named:demo_referral_client[indexPath.row % 3])
            return cell
        }
        else if collectionView == ongoingContestCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OngoingContestCell", for: indexPath) as! OngoingContestCell
            cell.respondButton.isSelected = test_btn_status[indexPath.row]
            
            cell.respondClicked = { cell in
                self.test_btn_status[indexPath.row] = cell.respondButton.isSelected
            }
            return cell
        }
        else if collectionView == contestJudgingCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestJudgingCell", for: indexPath) as! ContestJudgingCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestClosedCell", for: indexPath) as! ContestClosedCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featuredCollView {
            return CGSize(width: self.view.frame.width/2.5, height: collectionView.bounds.height)
        }
        else if collectionView == referralCollView {
            return CGSize(width: self.view.frame.width/2.8, height: collectionView.bounds.height)
        }
        else {
            return CGSize(width: self.view.frame.width/1.8, height: collectionView.bounds.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isClient {
            if segmentedControl.selectedSegmentIndex == 0 {
                self.performSegue(withIdentifier: "ClientContestDetails", sender: nil)
            }
        }
    }
    
    //MARK: Navigation (To Other VC) Methods
    @objc func showContestDetailList() {
        self.performSegue(withIdentifier: "ContestDetailList", sender: nil)
    }
    
}
