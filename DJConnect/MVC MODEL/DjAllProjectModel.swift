//
//  DjAllProjectModel.swift
//  DJConnect
//
//  Created by mac on 16/06/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class DjAllProjectDataDetail: Mappable{
    var id: NSNumber?
    var title: String?
    var project_by: String?
    var event_date: String?
    var event_start_time: String?
    var event_end_time: String?
    var genre: String?
    var expected: String?
    var project_image: String?
    var closing_time: String?
    var currency: String?
    var price: String?
    var is_old: String?
    var project_status: String?
    var is_cancelled: Int?
    var is_completed: Int?
    var waiting_count: Int?
    var accepted_count: Int?
    var nonaccepted_count: Int?
    var rate: String?
    var avg_rate: Int?
    var project_timezone: String?
    var project_timezone_UTC: String?
    var applied_id: NSNumber?
    var Applied_Status: String?
    var music_type: Int?
    var is_video_verify: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        project_by <- map["project_by"]
        event_date <- map["event_date"]
        event_start_time <- map["event_start_time"]
        event_end_time <- map["event_end_time"]
        genre <- map["genre"]
        expected <- map["expected"]
        project_image <- map["project_image"]
        closing_time <- map["closing_time"]
        currency <- map["currency"]
        price <- map["price"]
        is_old <- map["is_old"]
        project_status <- map["project_status"]
        is_cancelled <- map["is_cancelled"]
        is_completed <- map["is_completed"]
        waiting_count <- map["waiting_count"]
        accepted_count <- map["accepted_count"]
        nonaccepted_count <- map["nonaccepted_count"]
        rate <- map["rate"]
        avg_rate <- map["avg_rate"]
        project_timezone <- map["project_timezone"]
        project_timezone_UTC <- map["project_timezone_UTC"]
        applied_id <- map["applied_id"]
        Applied_Status <- map["Applied_Status"]
        music_type <- map["music_type"]
        is_video_verify <- map["is_video_verify"]
    }
}

class DjAllProjectModel: Mappable {
    var success: NSNumber?
    var message: String?
    var projects: [DjAllProjectDataDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projects <- map["projects"]
    }
}
