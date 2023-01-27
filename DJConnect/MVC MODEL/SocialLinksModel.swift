//
//  SocialLinksModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 05/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class socialDataLinkDetail: Mappable{
    var social_media_id: String?
    var social_media_logo: String?
    var social_media_name: String?
    var social_media_link: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        social_media_id <- map["social_media_id"]
        social_media_logo <- map["social_media_logo"]
        social_media_name <- map["social_media_name"]
        social_media_link <- map["social_media_link"]
    }
    
    
}

class SocialLinksModel: Mappable {
    var success: NSNumber?
    var message: String?
    var socialData: [socialDataLinkDetail]?
    required init?(map: Map) {
     
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        socialData <- map["result"]
    }
    

  
}
