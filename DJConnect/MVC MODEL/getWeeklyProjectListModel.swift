//
//  getWeeklyProjectListModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 27/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class weeklyProjectListDetails: Mappable{
    var id: NSNumber?
    var title: String?
    var project_by: String?
    var event_date: String?
    var event_start_time: String?
    var event_end_time: String?
    var genre: String?
    var expected: String?
    var project_image: String?
    var is_old: String?
    var is_cancelled: Int?
    var closing_time: String?
    var currency: String?
    var price: AnyObject?
    var waiting_count: Int?
    var accepted_count: Int?
    var nonaccepted_count: Int?
    var is_completed: Int?
    var project_status: String?
    var rate: String?
    var avg_rate: Int?
    var project_timezone: String?
    var project_timezone_UTC: String?
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
        is_old <- map["is_old"]
        is_cancelled <- map["is_cancelled"]
        currency <- map["currency"]
        price <- map["price"]
        waiting_count <- map["waiting_count"]
        accepted_count <- map["accepted_count"]
        nonaccepted_count <- map["nonaccepted_count"]
        is_completed <- map["is_completed"]
        project_status <- map["project_status"]
        rate <- map["rate"]
        avg_rate <- map["avg_rate"]
        project_timezone <- map["project_timezone"]
        project_timezone_UTC <- map["project_timezone_UTC"]
    }
    
}

class getWeeklyProjectListModel: Mappable{
    var success: NSNumber?
    var message: String?
    var projectList: [weeklyProjectListDetails]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projectList <- map["projects"]

    }

}
