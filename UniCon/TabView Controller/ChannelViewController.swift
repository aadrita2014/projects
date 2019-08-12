//
//  ChannelViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: IBOutlets Declarations
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var topSliderView:UIScrollView!
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: Category Labels & Collection View Declarations
    var featuredCategoryLabel:UILabel!
    var featuredCollView:UICollectionView!
    
    
    var referralClientLabel:UILabel!
    var referralCollView:UICollectionView!
    
    var ongoingContestLabel:UILabel!
    var ongoingContestCollView:UICollectionView!
    
    var contestJudgingLabel:UILabel!
    var contestJudgingCollView:UICollectionView!
    
    var contestClosedLabel:UILabel!
    var contestClosedCollView:UICollectionView!
    
    
    //MARK: Collection View Layout Declarations
    let featuredCollViewLayout = UICollectionViewFlowLayout()
    let referallClientViewLayout = UICollectionViewFlowLayout()
    let ongoingContestLayout = UICollectionViewFlowLayout()
    let contestJudgingLayout = UICollectionViewFlowLayout()
    let contestClosedLayout = UICollectionViewFlowLayout()
    
    
    //MARK: Demo Images Declaration
    var images:[String] = ["demo_image",
                           "demo_image",
                           "demo_image",
                           "demo_image",
                           "demo_image"]
    
    var test_btn_status = [false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Setup Top Slider
        setupTopSlider()
        pageControl.numberOfPages = images.count
        
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
        containerHeightConstraint.constant = contestClosedCollView.frame.origin.y + contestClosedCollView.frame.height
    
    }
    
    func addFeaturedCategoryView()
    {
        // Init & Setup Featured Category Label
        featuredCategoryLabel = UILabel(frame: CGRect(x: 8, y: topSliderView.frame.origin.y + topSliderView.frame.height + 8, width: self.view.frame.width, height: 30))
        featuredCategoryLabel.text = "추천 크리에이터"
        
        //Init & Setup Featured Collection View
        featuredCollViewLayout.scrollDirection = .horizontal
        featuredCollView = UICollectionView(frame: CGRect(x: 8, y: featuredCategoryLabel.frame.origin.y + featuredCategoryLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout:   featuredCollViewLayout)
        
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
        referralClientLabel = UILabel(frame: CGRect(x: 8, y: featuredCollView.frame.origin.y + featuredCollView.frame.height + 8, width: self.view.frame.width, height: 30))
        referralClientLabel.text = "추천 크리에이터"
        referralClientLabel.sizeToFit()
         //Init & Setup Referral Client Collection View
        referallClientViewLayout.scrollDirection = .horizontal
        referralCollView = UICollectionView(frame: CGRect(x: 8, y: referralClientLabel.frame.origin.y + referralClientLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/4), collectionViewLayout: referallClientViewLayout)
        referralCollView.register(UINib(nibName: "ReferralClientCell", bundle: nil), forCellWithReuseIdentifier: "ReferralClientCell")
        
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
        ongoingContestLabel = UILabel(frame: CGRect(x: 8, y: referralCollView.frame.origin.y + referralCollView.frame.height + 8, width: self.view.frame.width, height: 30))
        ongoingContestLabel.text = "추천 크리에이터"
        
        //Init & Setup Ongoing Contest Collection View
          ongoingContestLayout.scrollDirection = .horizontal
        ongoingContestCollView = UICollectionView(frame: CGRect(x: 8, y: ongoingContestLabel.frame.origin.y + ongoingContestLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/2.5), collectionViewLayout: ongoingContestLayout)
        ongoingContestCollView.register(UINib(nibName: "OngoingContestCell", bundle: nil), forCellWithReuseIdentifier: "OngoingContestCell")
        
        //Set the delegate to self
        ongoingContestCollView.dataSource = self
        ongoingContestCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(ongoingContestLabel)
        containerView.addSubview(ongoingContestCollView)
        //Reload the Collection view to reload the data and size of the collection view
        ongoingContestCollView.reloadData()
    }
    func addJudgingContestCollView()
    {
         // Init & Setup Judging Contest Category Label
        contestJudgingLabel = UILabel(frame: CGRect(x: 8, y: ongoingContestCollView.frame.origin.y + ongoingContestCollView.frame.height + 8, width: self.view.frame.width, height: 30))
        contestJudgingLabel.text = "추천 크리에이터"
        
         // Init & Setup Judging Contest Category Label
        contestJudgingLayout.scrollDirection = .horizontal
        contestJudgingCollView = UICollectionView(frame: CGRect(x: 8, y: contestJudgingLabel.frame.origin.y + contestJudgingLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: contestJudgingLayout)
        contestJudgingCollView.register(UINib(nibName: "ContestJudgingCell", bundle: nil), forCellWithReuseIdentifier: "ContestJudgingCell")
        
        //Set the delegate to self
        contestJudgingCollView.dataSource = self
        contestJudgingCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestJudgingLabel)
        containerView.addSubview(contestJudgingCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestJudgingCollView.reloadData()
    }
    func addClosedContestCollView()
    {
        //Init & Setup Judging Contest Category Label
        contestClosedLabel = UILabel(frame: CGRect(x: 8, y: contestJudgingCollView.frame.origin.y + contestJudgingCollView.frame.height + 8, width: self.view.frame.width, height: 30))
        contestClosedLabel.text = "추천 크리에이터"
        
        //Init & Setup Judging Contest Category Label
        contestClosedLayout.scrollDirection = .horizontal
        contestClosedCollView = UICollectionView(frame: CGRect(x: 8, y: contestClosedLabel.frame.origin.y + contestClosedLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3), collectionViewLayout: contestClosedLayout)
        contestClosedCollView.register(UINib(nibName: "ContestClosedCell", bundle: nil), forCellWithReuseIdentifier: "ContestClosedCell")
       
        //Set the delegate to self
        contestClosedCollView.dataSource = self
        contestClosedCollView.delegate = self
        
        //Add label & collection view to the container as sub views
        containerView.addSubview(contestClosedLabel)
        containerView.addSubview(contestClosedCollView)
        
        //Reload the Collection view to reload the data and size of the collection view
        contestClosedCollView.reloadData()
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
    }
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCreatorCell", for: indexPath) as! FeaturedCreatorCell
            return cell
        }
        else if collectionView == referralCollView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReferralClientCell", for: indexPath) as! ReferralClientCell
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
}
