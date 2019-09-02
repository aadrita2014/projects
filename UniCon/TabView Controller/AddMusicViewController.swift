//
//  AddMusicViewController.swift
//  UniCon
//
//  Created by Ricky on 9/2/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//Class for music info detail model inherited from music info class
class MusicInfoDetail:MusicInfo {
    var isFavorite:Bool = false
    var isSelected:Bool = false
}
struct MusicCategory {
    let image,name:String
    var isFavoriteCategory:Bool = false
}
class AddMusicViewController: UIViewController {

    //MARK: Cell Identifiers declarations
    fileprivate final let MUSIC_ADD_CELL_IDENTIFIER = "MusicAddInfoCell"
    fileprivate final let MUSIC_CAT_CELL_IDENTIFIER = "MusicCategoryCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var musicCategoryCollView: UICollectionView!
    @IBOutlet weak var musicListTv: UITableView!
    @IBOutlet weak var musicFilterSegmentControl: UISegmentedControl!
    
    //MARK: Other variables
    var musicCategories:[MusicCategory] = [
        
        MusicCategory(image: "favoriteCategory", name: "즐겨찾기", isFavoriteCategory: true),
        MusicCategory(image: "demo_featured_creator", name: "EDM", isFavoriteCategory: false),
        MusicCategory(image: "demo_featured_creator", name: "록", isFavoriteCategory: false),
        MusicCategory(image: "demo_featured_creator", name: "록", isFavoriteCategory: false),
        MusicCategory(image: "demo_featured_creator", name: "록", isFavoriteCategory: false),
        MusicCategory(image: "demo_featured_creator", name: "록", isFavoriteCategory: false)
        
    ]
    var musicList:[MusicInfoDetail] = []
    
    //MARK: OVerriden view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add default black color to the background
        self.view.addBlackBackgroundColor()
        
        //Other Setup View
        setupView()
    
    }
    
    //View setup
    func setupView() {
        //Register custom cells for table views
         musicListTv.register(UINib(nibName: MUSIC_ADD_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: MUSIC_ADD_CELL_IDENTIFIER)
        
        //Register custom cells for collection views
        musicCategoryCollView.register(UINib(nibName: MUSIC_CAT_CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: MUSIC_CAT_CELL_IDENTIFIER)
        
        //Segment Control setup
        musicFilterSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        musicFilterSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    }
}

//MARK: Collectionview delegate methods
extension AddMusicViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicCategories.count //Demo number to be fetched from the api
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MUSIC_CAT_CELL_IDENTIFIER, for: indexPath) as! MusicCategoryCell
        
        let category = self.musicCategories[indexPath.row]
        cell.setModel(model: category)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.viewWidth()/5.7, height: collectionView.viewHeight())
    }
}


//MARK: Tableview delegate methods
extension AddMusicViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10  //Demo number
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MUSIC_ADD_CELL_IDENTIFIER, for: indexPath) as! MusicAddInfoCell
        cell.musicSelectedAction = { cell in
            
            self.dismiss(animated: true, completion: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Fixed height for now
        return 100
    }
}
