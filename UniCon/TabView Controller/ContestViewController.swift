//
//  ContestViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ContestViewController: UIViewController {

    //MARK: IBOutlet Declarations
    @IBOutlet weak var likeLabel:UILabel!
    @IBOutlet weak var commentLabel:UILabel!
    @IBOutlet weak var shareLabel:UILabel!
    @IBOutlet weak var bookmarkLabel:UILabel!
    
    @IBOutlet weak var likeButton:UIButton!
    @IBOutlet weak var commentButton:UIButton!
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var bookmarkButton:UIButton!
    
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contestTitleLabel: UILabel!
    
    @IBOutlet weak var contestOrganizerLabel: UILabel!
    
    @IBOutlet weak var prizeMoneyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set Bookmark selected non selected states
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(named: "bookmark_selected"), for: .selected)
    }
    
    //MARK: IBAction Declarations
    @IBAction func likeClicked()
    {
        print("Like Clicked")
    }

    @IBAction func commentClicked()
    {
        print("Comment Clicked")
    }
    
    @IBAction func shareClicked()
    {
        print("Share Clicked")
    }
    
    @IBAction func bookmarkClicked()
    {
        print("Bookmark Clicked")
        bookmarkButton.isSelected = !bookmarkButton.isSelected
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
