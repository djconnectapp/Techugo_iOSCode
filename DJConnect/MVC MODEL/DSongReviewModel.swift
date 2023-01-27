//
//  DSongReviewModel.swift
//  DJConnect
//
//  Created by mac on 05/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class DjSongReviewDataDetail: Mappable{
    var audio_file: String?
    var closing_time: String?
    var audio_title: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_file <- map["audio_file"]
        closing_time <- map["closing_time"]
        audio_title <- map["audio_name"]
    }
    
}

class DSongReviewModel: Mappable {
    var success: NSNumber?
    var message: String?
    var audio_data: DjSongReviewDataDetail?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        audio_data <- map["audioData"]
    }
    


}
