//
//  GetBuyProjStepsModel.swift
//  DJConnect
//
//  Created by mac on 20/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class BuyStep5Details: Mappable{
    var rate_value: String?
    var review: String?
    var status: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        rate_value <- map["rate_value"]
        review <- map["review"]
        status <- map["status"]
    }
}

class BuyStep3Details: Mappable{
    var artist_id: Int?
    var artist_name: String?
    var artist_photo: String?
    var artist_applied_audio_name: String?
    var audio_file: String?
    var remaining_time: String?
    var status: Int?
    var artist_genre: String?
    var reason: String?
    var cost: String?
    var offering: String?
    var is_video_verify: Int?
    var project_timezone: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        artist_id <- map["artist_id"]
        artist_name <- map["artist_name"]
        artist_photo <- map["artist_photo"]
        artist_applied_audio_name <- map["artist_applied_audio_name"]
        audio_file <- map["audio_file"]
        remaining_time <- map["remaining_time"]
        status <- map["status"]
        artist_genre <- map["artist_genre"]
        reason <- map["reason"]
        cost <- map["cost"]
        offering <- map["offering"]
        is_video_verify <- map["is_video_verify"]
        project_timezone <- map["project_timezone"]
    }
}

class GetBuyProjStepsModel: Mappable{
    var success: NSNumber?
    var message: String?
    var is_completed: Int?
    var step1: String?
    var step2: String?
    var step3: BuyStep3Details?
    var step4: String?
    var step5: BuyStep5Details?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        is_completed <- map["is_completed"]
        step1 <- map["step1"]
        step2 <- map["step2"]
        step3 <- map["step3"]
        step4 <- map["step4"]
        step5 <- map["step5"]
    }
}
