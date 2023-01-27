//
//  SongStatusModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 03/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class appliedAudioDataDetail: Mappable{
    var artistid: Int?
    var artistname: String?
    var audioname: String?
    var audiofile: String?
    var profilepicture: String?
    var audioid: Int?
    var reason: String?
    var genre: String?
    var offering: String?
    var cost: String?
    var ar_currency: String?
    var project_price: String?
    var applied_broadcast_id: String?
    var is_video_verify: Int?
    var is_keep: Int?
    var previewImg: String?
    var closing_time_seconds: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        artistid <- map["artistid"]
        artistname <- map["artistname"]
        audioname <- map["audioname"]
        audiofile <- map["audiofile"]
        profilepicture <- map["profilepicture"]
        audioid <- map["audioid"]
        reason <- map["reason"]
        genre <- map["genre"]
        offering <- map["offering"]
        cost <- map["cost"]
        ar_currency <- map["ar_currency"]
        project_price <- map["project_price"]
        applied_broadcast_id <- map["applied_broadcast_id"]
        is_video_verify <- map["is_video_verify"]
        is_keep <- map["is_keep"]
        previewImg <- map["previewImg"]
        closing_time_seconds <- map["closing_time_seconds"]
    }
    
    
}

class SongStatusModel: Mappable {
    var success: NSNumber?
    var message: String?
    var appliedAudioData: [appliedAudioDataDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        appliedAudioData <- map["appliedAudioData"]
    }

    
}
