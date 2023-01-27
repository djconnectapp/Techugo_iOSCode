//
//  BlockListModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 04/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class blockProfileData: Mappable {
    var block_id: Int?
    var block_user_id: String?
    var block_user_name: String?
    var profile_image: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        block_user_id <- map["block_user_id"]
        block_user_name <- map["block_user_name"]
        profile_image <- map["profile_image"]
        block_id <- map["block_id"]
    }
    
}

class BlockListModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responseData: [blockProfileData]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["responseData"]
    }
    
}

