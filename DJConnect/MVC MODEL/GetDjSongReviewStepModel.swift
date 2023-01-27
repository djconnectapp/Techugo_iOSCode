//
//  GetDjSongReviewStepModel.swift
//  DJConnect
//
//  Created by mac on 06/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class DjSongReviewStep3Detail: Mappable{
    var step3_status: String?
    var remaining_time: String?
    var is_video: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        step3_status <- map["step3_status"]
        remaining_time <- map["remaining_time"]
        is_video <- map["is_video"]
    }
    
    
}

class DjSongReviewStep2Detail: Mappable{
    var step2_status: String?
    var audio_name: String?
    var audio_file: String?
    var artist_genre: String?
    var dj_id: String?
    var dj_name: String?
    var dj_pic: String?
//    var song_review_cost: NSNumber?
    var song_review_cost: String?
    var artist_name: String?
    var artist_pic: String?
    
    var video_file: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        step2_status <- map["step2_status"]
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
        artist_genre <- map["artist_genre"]
        dj_id <- map["dj_id"]
        dj_name <- map["dj_name"]
        dj_pic <- map["dj_pic"]
        song_review_cost <- map["song_review_cost"]
        artist_name <- map["artist_name"]
        artist_pic <- map["artist_pic"]
        video_file <- map["video_file"]
    }
    
    
}

class GetDjSongReviewStepModel: Mappable {
    var success: NSNumber?
    var message: String?
    var step1: String?
    var step2: DjSongReviewStep2Detail?
    var step3: DjSongReviewStep3Detail?
    var step4: String?
    var song_review_id: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        step1 <- map["step1"]
        step2 <- map["step2"]
        step3 <- map["step3"]
        step4 <- map["step4"]
        song_review_id <- map["song_review_id"]
    }
    
    
    
}
