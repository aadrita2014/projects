//
//  ChannelViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var topSliderView:UIScrollView!
    @IBOutlet weak var pageControl:UIPageControl!
    
    var featuredCategoryLabel:UILabel!
    var featuredCollView:UICollectionView!
    
    
    let layout = UICollectionViewFlowLayout()
    var images:[String] = ["demo_image",
                           "demo_image",
                           "demo_image",
                           "demo_image",
                           "demo_image"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Default Background Color to the view
        self.view.addDefaultBackgroundColor()
        
        layout.scrollDirection = .horizontal
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Setup Top Slider
        setupTopSlider()
        pageControl.numberOfPages = images.count
    }
    
    func addFeaturedCategoryView()
    {
        featuredCategoryLabel = UILabel(frame: CGRect(x: 8, y: topSliderView.frame.origin.y + topSliderView.frame.height + 8, width: self.view.frame.width, height: 30))
        featuredCategoryLabel.text = "추천 크리에이터"
        featuredCollView = UICollectionView(frame: CGRect(x: 8, y: featuredCategoryLabel.frame.origin.y + featuredCategoryLabel.frame.height + 8, width: self.view.frame.width, height: self.view.frame.height/3))
        featuredCollView.register(UINib(nibName: "FeaturedCreatorCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCreatorCell")
        featuredCollView.collectionViewLayout = layout
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featuredCollView
        {
            return CGSize(width: self.view.frame.width/3, height: collectionView.bounds.height)
        }
        return CGSize(width: 0, height: 0)
    }
    
    
}
