//
//  FavedMeModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 12/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class favedMeDataDetail: Mappable{
    var userid: Int?
    var name: String?
    var profile_pic: String?
    var usertype: String?
    var is_favorite: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["name"]
        profile_pic <- map["profile_pic"]
        usertype <- map["usertype"]
        is_favorite <- map["is_favorite"]
    }
}

class FavedMeModel: Mappable {
    var success: NSNumber?
    var message: String?
    var userData: [favedMeDataDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userData <- map["userData"]
    }
}
