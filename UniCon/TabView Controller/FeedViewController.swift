//
//  FeedViewController.swift
//  UniCon
//
//  Created by Ricky on 8/10/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: IBOutlets Declared
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    
    var contestViewController: ContestViewController? = nil
    var generalVideosViewController: GeneralVideosViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Black background color for some of the designs
        self.view.addBlackBackgroundColor()
        
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
    //MARK: IBActions Declared
    @IBAction func segmentValueChanged() {
        if segmentedControl.selectedSegmentIndex == 0
        {
            //TODO: Show Contest View
            showContestView()
        }
        else
        {
            //TODO: Show General Videos View
            showGeneralVideosView()
        }
    }
    
    func showContestView() {
        if contestViewController == nil {
            contestViewController = self.storyboard!.instantiateViewController(withIdentifier: "CONTEST_VIEW") as? ContestViewController
            contestViewController?.view.frame = self.containerView.bounds;
            contestViewController?.willMove(toParent: self)
            self.containerView.addSubview(contestViewController!.view)
            self.addChild(contestViewController!)
            contestViewController!.didMove(toParent: self)
        }
        else {
            if generalVideosViewController != nil {
                generalVideosViewController?.view.isHidden = true
            }
            contestViewController?.view.isHidden = false
        }
    }
    
    func showGeneralVideosView() {
        if generalVideosViewController == nil {
            generalVideosViewController = self.storyboard!.instantiateViewController(withIdentifier: "GENERAL_VIDEOS_VIEW") as? GeneralVideosViewController
            generalVideosViewController?.view.frame = self.containerView.bounds;
            generalVideosViewController?.willMove(toParent: self)
            self.containerView.addSubview(generalVideosViewController!.view)
            self.addChild(generalVideosViewController!)
            generalVideosViewController!.didMove(toParent: self)
        }
        else {
            if contestViewController != nil {
                contestViewController?.view.isHidden = true
            }
            generalVideosViewController?.view.isHidden = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
