//
//  GetDjRemixStepModel.swift
//  DJConnect
//
//  Created by mac on 20/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class RemixStep3Details: Mappable{
    var step3_status: String?
    var audio_name: String?
    var audio_file: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        step3_status <- map["step3_status"]
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
    }
}

class RemixStep2Details: Mappable{
    var step2_status: String?
    var artist_genre: String?
    var audio_name: String?
    var audio_file: String?
    var dj_id: Int?
    var dj_name: String?
    var dj_pic: String?
    var artist_name: String?
    var artist_pic: String?
    var dj_remix_cost: String?
    var djremix_description: String?
    var remaining_time: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        step2_status <- map["step2_status"]
        artist_genre <- map["artist_genre"]
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
        dj_id <- map["dj_id"]
        dj_name <- map["dj_name"]
        dj_pic <- map["dj_pic"]
        artist_name <- map["artist_name"]
        artist_pic <- map["artist_pic"]
        dj_remix_cost <- map["dj_remix_cost"]
        djremix_description <- map["djremix_description"]
        remaining_time <- map["remaining_time"]
    }
}


class GetDjRemixStepModel: Mappable {
    var success: NSNumber?
    var message: String?
    var dj_remix_id: String?
    var step1: String?
    var step2: RemixStep2Details?
    var step3: RemixStep3Details?
    var step4: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        dj_remix_id <- map["dj_remix_id"]
        step1 <- map["step1"]
        step2 <- map["step2"]
        step3 <- map["step3"]
        step4 <- map["step4"]
    }
   

}
