//
//  MusicInfo.swift
//  UniCon
//
//  Created by Ricky on 9/17/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//To be inherited for other classes
class MusicInfo:NSObject {
    let image,title,artistInfo,duration:String
    
    init(image:String,title:String,artistInfo:String,duration:String) {
        self.image = image
        self.title = title
        self.artistInfo = artistInfo
        self.duration = duration
    }
}
//Class for music info detail model inherited from music info class
class MusicInfoDetail:MusicInfo {
    var isFavorite:Bool = false
    var isSelected:Bool = false
}
struct MusicCategory {
    let image,name:String
    var isFavoriteCategory:Bool = false
}
