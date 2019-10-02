//
//  ImagerViewerVC.swift
//  UniCon
//
//  Created by Ricky on 8/31/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class ImageViewerVC: UIViewController {

    var image:UIImage? = nil
    
    @IBOutlet weak var imageViewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewer.image = image!
    }
    
    //To dismiss the view
    @IBAction func dismissViewClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
