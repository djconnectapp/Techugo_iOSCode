//
//  GetDjStatsModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 06/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class AvgTimeDetails: Mappable{
    var total_time: String?
    var last_month_time: String?
    var top_user_time: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_time <- map["total_time"]
        last_month_time <- map["last_month_time"]
        top_user_time <- map["top_user_time"]
    }
    
    
}

class djStatsProfileViewerDetails: Mappable{
    var total_viewer: NSNumber?
    var last_month_viewer: NSNumber?
    var top_user: NSNumber?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_viewer <- map["total_viewer"]
        last_month_viewer <- map["last_month_viewer"]
        top_user <- map["top_user"]
    }
    
    
}

class djStatsFavoredDetails: Mappable{
    var total_favored: NSNumber?
    var last_month_favored: NSNumber?
    var top_user: NSNumber?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_favored <- map["total_favored"]
        last_month_favored <- map["last_month_favored"]
        top_user <- map["top_user"]
    }
    
    
}

class djStatsProjectsDetails: Mappable{
    var total_project: NSNumber?
    var last_month_project: NSNumber?
    var top_user: NSNumber?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_project <- map["total_project"]
        last_month_project <- map["last_month_project"]
        top_user <- map["top_user"]
    }
    
}

class GetDjStatsModel: Mappable {
    var success: NSNumber?
    var message: String?
    var projects: [djStatsProjectsDetails]?
    var favored: [djStatsFavoredDetails]?
    var profile_viewer: [djStatsProfileViewerDetails]?
    var Avg_time: [AvgTimeDetails]?
    var rating_count: String?
    var total_user: String?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projects <- map["projects"]
        favored <- map["favored"]
        profile_viewer <- map["profile_viewer"]
        Avg_time <- map["Avg_time"]
        rating_count <- map["rating_count"]
        total_user <- map["total_user"]
    }
}
