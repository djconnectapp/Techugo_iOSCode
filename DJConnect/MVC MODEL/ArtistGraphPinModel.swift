//
//  ArtistGraphPinModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 16/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class ArtistPinDataDetail: Mappable{
    var project_id: NSNumber?
    var project_title: String?
    var project_image: String?
    var project_cost: String?
    var project_by: String?
    var event_date: String?
    var event_start_time: String?
    var event_end_time: String?
    var project_genre: String?
    var expected_audience: String?
    var remaining_time: String?
    var latitude: String?
    var longitude: String?
    var dj_id: Int?
    var profile_image: String?
    var currency: String?
    var is_buy_project: Int?
    var is_buy_offer: Int?
    var is_completed: Int?
    var is_cancelled: Int?
    var is_old: String?
    var project_status: String?
    var is_dj_verify: NSNumber?
    var rate: String?
    var avg_rate: Int?
    var project_timezone: String?
    var project_timezone_UTC: String?
    var music_type: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        project_id <- map["project_id"]
        project_title <- map["project_title"]
        project_image <- map["project_image"]
        project_cost <- map["project_cost"]
        project_by <- map["project_by"]
        event_date <- map["event_date"]
        event_start_time <- map["event_start_time"]
        event_end_time <- map["event_end_time"]
        project_genre <- map["project_genre"]
        expected_audience <- map["expected_audience"]
        remaining_time <- map["remaining_time"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        dj_id <- map["dj_id"]
        profile_image <- map["profile_image"]
        currency <- map["currency"]
        is_buy_project <- map["is_buy_project"]
        is_buy_offer <- map["is_buy_offer"]
        is_completed <- map["is_completed"]
        is_cancelled <- map["is_cancelled"]
        is_old <- map["is_old"]
        project_status <- map["project_status"]
        is_dj_verify <- map["is_dj_verify"]
        rate <- map["rate"]
        avg_rate <- map["avg_rate"]
        project_timezone <- map["project_timezone"]
        project_timezone_UTC <- map["project_timezone_UTC"]
        music_type <- map["music_type"]
    }
    
    
}

class ArtistGraphPinModel: Mappable {
    var success: NSNumber?
    var message: String?
    var graphPinData: [ArtistPinDataDetail]?
    required init?(map: Map) {
     
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        graphPinData <- map["graphPinData"]
    }
    

   

   

}
