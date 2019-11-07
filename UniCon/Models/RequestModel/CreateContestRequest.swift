//
//  CreateContestRequest.swift
//  UniCon
//
//  Created by 10decoders on 05/11/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit
import EVReflection

class CreateContestRequest:EVObject {
    
    var userId:String = ""
    var title:String = ""
    var grade:String = ""
    var contactName:String = ""
    var contactPhone:String = ""
    var startTime:String = ""
    var endTime:String = ""
    var examinationStartTime:String = ""
    var examinationEndTime:String = ""
    var publicationTime:String = ""
    var content:String = ""
    var totalPrize:String = ""
    var platformFee:String = ""
    var first:String = ""
    var second:String = ""
    var third:String = ""
    var guideVideUrl:String = ""
      var referenceImage:String = ""
      var guideVideThumbnailUrl:String = ""
    required init() {
        
    }
}
