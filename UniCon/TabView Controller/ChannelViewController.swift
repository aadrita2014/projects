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
    var featuredCollView,referralCollView,ongoingContestCollView,contestJudgingCollView,contestClosedCollView:UICollectionView!
    
    //MARK: Collection View Layout Declarations
    let featuredCollViewLayout = UICollectionViewFlowLayout()
    let referallClientViewLayout = UICollectionViewFlowLayout()
    let ongoingContestLayout = UICollectionViewFlowLayout()
    let contestJudgingLayout = UICollectionViewFlowLayout()
    let contestClosedLayout = UICollectionViewFlowLayout()
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewSetup == false
        {
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
        //Add Featured Collection View Programmatically
        addFeaturedCategoryView()
        //Add Referral Client Collection View Programmatically
        addReferralClientCollView()
        //Add Ongoing Collection View Programmatically
        addOngoingContestCollView()
        //Add Contest Judging Collection View Programmatically
        addJudgingContestCollView()
        //Add Closed Contest Collection View Programmatically
        addClosedContestCollView()
        
        //Adjust the container view height according to the content
        containerHeightConstraint.constant = contestClosedCollView.frame.origin.y + contestClosedCollView.frame.height + 20
    }
    
    
    //MARK: Textfield delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //MARK: Slider Setup
    func setupTopSlider()
    {
        var xOrigin = CGFloat(0)
        for (index,image) in images.enumerated()
        {
            let imageView = UIImageView(frame:  CGRect(x: xOrigin, y: 0, width: self.view.frame.width , height: self.topSliderView.bounds.height))
            imageView.image = UIImage(named: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            topSliderView.addSubview(imageView)
            xOrigin = self.view.frame.width * CGFloat(index + 1)
        }
        topSliderView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(images.count), height: topSliderView.bounds.height)
        pageControl.numberOfPages = images.count
        containerView.bringSubviewToFront(pageControl)
    }
    //MARK: ScrollView Delegate
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == topSliderView
        {
            if scrollView.contentOffset.x > 0
            {
                let index = Int (scrollView.contentOffset.x / scrollView.bounds.width)
                pageControl.currentPage = index + 1
            }
            else
            {
                pageControl.currentPage = 0
            }
        }
        self.view.endEditing(true)
    }
    
    //MARK: Collection View Initialisation & Label Initialisations
    func addFeaturedCategoryView()
    {
        // Init & Setup Featured Category Label
        let featuredCategoryLabel = UILabel(frame: CGRect(x: 8, y: topSliderView.frame.origin.y + topSliderView.frame.height + 8, width: self.view.frame.width, height: 30))
        featuredCategoryLabel.text = "추천 크리에이터"
        featuredCategoryLabel.textColor = UIColor.white
        
        
        
        //Init & Setup Featured Collection View
        featuredCollViewLayout.scrollDirection = .horizontal
        featuredCollView = UICollectionView(frame: CGRect(x: 8, y: featuredCategoryLabel.frame.origin.y + featuredCategoryLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout:   featuredCollViewLayout)
        featuredCollView.showsHorizontalScrollIndicator = false
        featuredCollView.register(UINib(nibName: "FeaturedCreatorCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCreatorCell")
        
        //Set the delegate to self
        featuredCollView.dataSource = self
        featuredCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(featuredCategoryLabel)
        containerView.addSubview(featuredCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        
        featuredCollView.reloadData()
    }
    
    func addReferralClientCollView()
    {
        // Init & Setup Referral Client Category Label
        let referralClientLabel = UILabel(frame: CGRect(x: 8, y: featuredCollView.frame.origin.y + featuredCollView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        referralClientLabel.text = "추천 클라이언트"
        referralClientLabel.textColor = UIColor.white
        
        //Init & Setup Referral Client Collection View
        referallClientViewLayout.scrollDirection = .horizontal
        referralCollView = UICollectionView(frame: CGRect(x: 8, y: referralClientLabel.frame.origin.y + referralClientLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/4), collectionViewLayout: referallClientViewLayout)
        referralCollView.register(UINib(nibName: "ReferralClientCell", bundle: nil), forCellWithReuseIdentifier: "ReferralClientCell")
        referralCollView.showsHorizontalScrollIndicator = false
        
        //Set the delegate to self
        referralCollView.dataSource = self
        referralCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(referralClientLabel)
        containerView.addSubview(referralCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        referralCollView.reloadData()
    }
    
    func addOngoingContestCollView()
    {
        // Init & Setup Ongoing Contest Category Label
        let ongoingContestLabel = UILabel(frame: CGRect(x: 8, y: referralCollView.frame.origin.y + referralCollView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        ongoingContestLabel.text = "진행중 콘테스트"
        ongoingContestLabel.textColor = UIColor.white
        
        
        //Show More Button
        let showMoreButton = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreButton.center.y = ongoingContestLabel.center.y
        showMoreButton.setImage(UIImage(named: "next_arrow"), for: .normal)
        
        
        //Init & Setup Ongoing Contest Collection View
        ongoingContestLayout.scrollDirection = .horizontal
        ongoingContestCollView = UICollectionView(frame: CGRect(x: 8, y: ongoingContestLabel.frame.origin.y + ongoingContestLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/2.5), collectionViewLayout: ongoingContestLayout)
        ongoingContestCollView.register(UINib(nibName: "OngoingContestCell", bundle: nil), forCellWithReuseIdentifier: "OngoingContestCell")
        ongoingContestCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        ongoingContestCollView.dataSource = self
        ongoingContestCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(ongoingContestLabel)
        containerView.addSubview(showMoreButton)
        containerView.addSubview(ongoingContestCollView)
        //Reload the Collection view to reload the data and size of the collection view
        ongoingContestCollView.reloadData()
    }
    func addJudgingContestCollView()
    {
        // Init & Setup Judging Contest Category Label
        let contestJudgingLabel = UILabel(frame: CGRect(x: 8, y: ongoingContestCollView.frame.origin.y + ongoingContestCollView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        contestJudgingLabel.text = "심사중 콘테스트"
        contestJudgingLabel.textColor = UIColor.white
        
        //Show More Button
        let showMoreButton = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreButton.center.y = contestJudgingLabel.center.y
        showMoreButton.setImage(UIImage(named: "next_arrow"), for: .normal)
        
        // Init & Setup Judging Contest Category Label
        contestJudgingLayout.scrollDirection = .horizontal
        contestJudgingCollView = UICollectionView(frame: CGRect(x: 8, y: contestJudgingLabel.frame.origin.y + contestJudgingLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/2.5), collectionViewLayout: contestJudgingLayout)
        contestJudgingCollView.register(UINib(nibName: "ContestJudgingCell", bundle: nil), forCellWithReuseIdentifier: "ContestJudgingCell")
        contestJudgingCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        contestJudgingCollView.dataSource = self
        contestJudgingCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestJudgingLabel)
        containerView.addSubview(showMoreButton)
        containerView.addSubview(contestJudgingCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestJudgingCollView.reloadData()
    }
    func addClosedContestCollView()
    {
        //Init & Setup Judging Contest Category Label
        let contestClosedLabel = UILabel(frame: CGRect(x: 8, y: contestJudgingCollView.frame.origin.y + contestJudgingCollView.frame.height + const_top_margin, width: self.view.frame.width, height: 30))
        contestClosedLabel.text = "종료된 콘테스트"
        contestClosedLabel.textColor = UIColor.white
        
        //Show More Button
        let showMoreButton = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 50, height: 100))
        showMoreButton.center.y = contestClosedLabel.center.y
        showMoreButton.setImage(UIImage(named: "next_arrow"), for: .normal)
        
        //Init & Setup Judging Contest Category Label
        contestClosedLayout.scrollDirection = .horizontal
        contestClosedCollView = UICollectionView(frame: CGRect(x: 8, y: contestClosedLabel.frame.origin.y + contestClosedLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/2.5), collectionViewLayout: contestClosedLayout)
        contestClosedCollView.register(UINib(nibName: "ContestClosedCell", bundle: nil), forCellWithReuseIdentifier: "ContestClosedCell")
        contestClosedCollView.showsHorizontalScrollIndicator = false
        //Set the delegate to self
        contestClosedCollView.dataSource = self
        contestClosedCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestClosedLabel)
        containerView.addSubview(showMoreButton)
        containerView.addSubview(contestClosedCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestClosedCollView.reloadData()
    }
    
    
    
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCreatorCell", for: indexPath) as! FeaturedCreatorCell
            cell.creatorProfilePic.image = UIImage(named:demo_featured_creator[indexPath.row % 2])
            return cell
        }
        else if collectionView == referralCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReferralClientCell", for: indexPath) as! ReferralClientCell
            cell.clientLogo.image = UIImage(named:demo_referral_client[indexPath.row % 3])
            return cell
        }
        else if collectionView == ongoingContestCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OngoingContestCell", for: indexPath) as! OngoingContestCell
            cell.respondButton.isSelected = test_btn_status[indexPath.row]
            
            cell.respondClicked = { cell in
                self.test_btn_status[indexPath.row] = cell.respondButton.isSelected
            }
            return cell
        }
        else if collectionView == contestJudgingCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestJudgingCell", for: indexPath) as! ContestJudgingCell
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestClosedCell", for: indexPath) as! ContestClosedCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featuredCollView
        {
            return CGSize(width: self.view.frame.width/2.5, height: collectionView.bounds.height)
        }
        else if collectionView == referralCollView
        {
            return CGSize(width: self.view.frame.width/2.8, height: collectionView.bounds.height)
        }
        else
        {
            return CGSize(width: self.view.frame.width/1.8, height: collectionView.bounds.height)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
