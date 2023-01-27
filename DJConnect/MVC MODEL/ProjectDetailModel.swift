//
//  ProjectDetailModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 12/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class spin_submissionDetail: Mappable{
    var audioid: String?
    var artistid: Int?
    var artistname: String?
    var audioname: String?
    var audiofile: String?
    var profilepicture: String?
    required init?(map: Map) {
        
    }
  
    func mapping(map: Map) {
        artistid <- map["artistid"]
        artistname <- map["artistname"]
        audioname <- map["audioname"]
        audiofile <- map["audiofile"]
        profilepicture <- map["profilepicture"]
        audioid <- map["audioid"]
    }
    
    
}

class projectDetailData: Mappable{
    var userid: NSNumber?
    var project_by: String?
    var profile_image: String?
    var projectid: NSNumber?
    var title: String?
    var project_image: String?
    var project_description: String?
    var project_info_type: String?
    var project_info_audiance: String?
    var venue_name: String?
    var event_date: String?
    var event_start_time: String?
    var event_end_time: String?
    var venue_address: String?
    var venue_address_status: String?
    var genre: String?
    var special_Information: String?
    var currency: String?
    var price: String?
    var closing_time: String?
    var spin_submission: [spin_submissionDetail]?
    var is_cancelled: Int?
    var is_completed: Int?
    var is_favorite: Int?
    var event_day_date: String?
    var regulation: String?
    var Applied_Status: Int?
    var latitude: String?
    var longitude: String?
    var any_artist_apply: Int?
    var artist_offer: String?
    var is_buy_offer: Int?
    var is_buy_project: Int?
    var project_status: String?
    var is_old: String?
    var project_timezone: String?
    var project_timezone_UTC: String?
    var genre_ids: String?
    var audio_status: String?
    var is_video_verify: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        project_by <- map["project_by"]
        profile_image <- map["profile_image"]
        projectid <- map["projectid"]
        title <- map["title"]
        project_image <- map["project_image"]
        project_description <- map["project_description"]
        project_info_type <- map["project_info_type"]
        project_info_audiance <- map["project_info_audiance"]
        venue_name <- map["venue_name"]
        event_date <- map["event_date"]
        event_start_time <- map["event_start_time"]
        event_end_time <- map["event_end_time"]
        venue_address <- map["venue_address"]
        venue_address_status <- map["venue_address_status"]
        genre <- map["genre"]
        special_Information <- map["special_Information"]
        currency <- map["currency"]
        price <- map["price"]
        closing_time <- map["closing_time"]
        spin_submission <- map["spin_submission"]
        is_cancelled <- map["is_cancelled"]
        is_completed <- map["is_completed"]
        is_favorite <- map["is_favorite"]
        event_day_date <- map["event_day_date"]
        regulation <- map["regulation"]
        Applied_Status <- map["Applied_Status"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        any_artist_apply <- map["any_artist_apply"]
        artist_offer <- map["artist_offer"]
        is_buy_offer <- map["is_buy_offer"]
        is_buy_project <- map["is_buy_project"]
        project_status <- map["project_status"]
        is_old <- map["is_old"]
        project_timezone <- map["project_timezone"]
        project_timezone_UTC <- map["project_timezone_UTC"]
        genre_ids <- map["genre_ids"]
        audio_status <- map["audio_status"]
        is_video_verify <- map["is_video_verify"]
    }

}
class ProjectDetailModel: Mappable {
    var success: NSNumber?
    var message: String?
    var projectDetails: [projectDetailData]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projectDetails <- map["projectDetails"]
    }
    


}
