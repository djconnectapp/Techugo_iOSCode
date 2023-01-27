//
//  BuyProjectStatusModel.swift
//  DJConnect
//
//  Created by mac on 25/03/20.
//  Copyright © 2020 mac. All rights reserved.
//
//
import UIKit
import ObjectMapper

class buyProjStatusDetail: Mappable{
    var artist_id: Int?
    var artist_name: String?
    var artist_photo: String?
    var artist_applied_audio_name: String?
    var audio_file: String?
    var remaining_time: String?
    var status: Int?
    var project_timezone: String?
    var project_timezone_UTC: String?
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
        project_timezone <- map["project_timezone"]
        project_timezone_UTC <- map["project_timezone_UTC"]
    }


}

class BuyProjectStatusModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responseData: buyProjStatusDetail?
    required init?(map: Map) {
       
    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["responseData"]
    }




}
