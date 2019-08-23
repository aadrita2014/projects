//
//  GeneralVideosViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class GeneralVideosViewController: UIViewController {

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
   
    
    //MARK: Other declarations
    var sharePopUpView:SharePopUpView? = nil   //Definition when share button is clicked
    var sharedFeedPopup:FeedSharedPopUpPrimary? = nil
    
    //MARK: Overrided View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Bookmark selected non selected states
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(named: "bookmark_selected"), for: .selected)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: IBAction Declarations
    @IBAction func likeClicked() {
        print("Like Clicked")
    }
    
    @IBAction func commentClicked() {
       print("Comment Clicked")
    }
    
    @IBAction func shareClicked() {
        showShareView()
    }
    
    @IBAction func bookmarkClicked() {
        print("Bookmark Clicked")
        bookmarkButton.isSelected = !bookmarkButton.isSelected
    }
    
    //MARK: Share PopUp Methods
    func showShareView() {
        //To avoid the duplicate initialisation
        if sharePopUpView == nil {
            sharePopUpView = SharePopUpView(frame: CGRect(x: 0, y: view.viewHeight() - (self.view.viewHeight()/4), width: view.viewWidth(), height: (view.viewHeight()/4)))
            
            //Remove share view from the view
            sharePopUpView?.removeViewClicked = {
                self.removeShareView()
            }
            //Show Shared Successfully Pop Up View
            sharePopUpView?.shareSuccessful = {
                //Remove the share view
                self.removeShareView()
                self.showSharedPopUpView()
            }
            self.view.addSubview(sharePopUpView!)
        }
    }
    func removeShareView() {
        //Check if view is not nil
        if let view = sharePopUpView {
            view.removeFromSuperview()
            sharePopUpView = nil
        }
    }
    
    //MARK: Shared Feed Popup Methods
    func showSharedPopUpView() {
        //To avoid the duplicate initialisation
        if sharedFeedPopup == nil {
            sharedFeedPopup = FeedSharedPopUpPrimary(frame: CGRect(x: 0, y: 0, width: view.viewWidth(), height: view.viewHeight()))
            sharedFeedPopup?.dismissClicked = {
                self.removeSharedPopUpView()
            }
            self.view.addSubview(sharedFeedPopup!)
        }
    }
    func removeSharedPopUpView() {
        if let view = sharedFeedPopup {
            view.removeFromSuperview()
            sharedFeedPopup = nil
        }
    }
}
