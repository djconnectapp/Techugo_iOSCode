//
//  GetDjDropStepModel.swift
//  DJConnect
//
//  Created by mac on 21/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class DropStep3Details: Mappable{
    var status: String?
    var audio_name: String?
    var audio_file: String?
    var artist_name: String?
    var artist_genre: String?
    var artist_profile: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
        artist_name <- map["artist_name"]
        artist_genre <- map["artist_genre"]
        artist_profile <- map["artist_profile"]
    }
    
    
}

class DropStep2Details: Mappable{
    var dj_drop_title: String?
    var dj_drop_des: String?
    var dj_id: Int?
    var dj_name: String?
    var dj_pic: String?
    var dj_drop_cost: String?
    var remaining_time: String?
    var status: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dj_drop_title <- map["dj_drop_title"]
        dj_drop_des <- map["dj_drop_des"]
        dj_name <- map["dj_name"]
        remaining_time <- map["remaining_time"]
        status <- map["status"]
        dj_id <- map["dj_id"]
        dj_pic <- map["dj_pic"]
        dj_drop_cost <- map["dj_drop_cost"]
    }
}


class GetDjDropStepModel: Mappable {
    var success: NSNumber?
    var message: String?
    var step1: String?
    var step2: DropStep2Details?
    var step3: DropStep3Details?
    var step4: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        step1 <- map["step1"]
        step2 <- map["step2"]
        step3 <- map["step3"]
        step4 <- map["step4"]
    }
   

}
