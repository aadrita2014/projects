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
    
    //MARK: Share PopUp Definitions
    func showShareView() {
        if sharePopUpView == nil {
            sharePopUpView = SharePopUpView(frame: CGRect(x: 0, y: view.viewHeight() - (self.view.viewHeight()/4), width: view.viewWidth(), height: (view.viewHeight()/4)))
            sharePopUpView?.removeViewClicked = {
                self.removeShareView()
            }
            self.view.addSubview(sharePopUpView!)
        }
    }
    func removeShareView() {
        if let view = sharePopUpView {
            view.removeFromSuperview()
            sharePopUpView = nil
        }
    }
   
}
