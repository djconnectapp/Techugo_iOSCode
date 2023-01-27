//
//  GetProfileModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 25/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class recentDataDetail: Mappable{
    var media_audio_name: String?
    var media_audio: String?
    var media_type: String?
    var Broadcast_id: String?
    var dj_name: String?
    var created_date: String?
    var event_name: String?
    var media_image : String?
    var project_name : String?
    var ar_name : String?
    var verify_status : Int?
    var project_id : Int?
    var id: Int?
    var sender_id: Int?
    var media_id: Int?
   
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        media_audio_name <- map["media_audio_name"]
        media_audio <- map["media_audio"]
        media_type <- map["media_type"]
        Broadcast_id <- map["Broadcast_id"]
        dj_name <- map["dj_name"]
        created_date <- map["created_date"]
        event_name <- map["event_name"]
        media_image <- map["media_image"]
        project_name  <- map["project_name"]
        ar_name <- map["ar_name"]
        verify_status  <- map["verify_status"]
        project_id <- map["project_id"]
        sender_id <- map["sender_id"]
        id <- map["id"]
        media_id <- map["media_id"]
        
    }
    
    
}

class feedBackDropDetail: Mappable{
    var dj_remix: String?
    var dj_remix_status: String?
    var dj_remix_currency: String?
    var is_dj_remix_varying: Int?
    var dj_remix_range1: Int?
    var dj_remix_range2: Int?
    var dj_remix_price: String?
    var dj_feedback: String?
    var dj_feedback_status: String?
    var dj_feedback_currency: String?
    var dj_feedback_price: String?
    var dj_drops: String?
    var dj_drops_status: String?
    var dj_drops_currency: String?
    var dj_drops_price: String?
    var is_dj_feedback_varying: Int?
    var dj_feedback_range1: Int?
    var dj_feedback_range2: Int?
    var is_dj_drop_varying: Int?
    var dj_drop_range1: Int?
    var dj_drop_range2: Int?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        dj_feedback <- map["dj_feedback"]
        dj_feedback_status <- map["dj_feedback_status"]
        dj_feedback_currency <- map["dj_feedback_currency"]
        dj_feedback_price <- map["dj_feedback_price"]
        dj_drops <- map["dj_drops"]
        dj_drops_status <- map["dj_drops_status"]
        dj_drops_currency <- map["dj_drops_currency"]
        dj_drops_price <- map["dj_drops_price"]
        is_dj_feedback_varying <- map["is_dj_feedback_varying"]
        dj_feedback_range1 <- map["dj_feedback_range1"]
        dj_feedback_range2 <- map["dj_feedback_range2"]
        is_dj_drop_varying <- map["is_dj_drop_varying"]
        dj_drop_range1 <- map["dj_drop_range1"]
        dj_drop_range2 <- map["dj_drop_range2"]
        dj_remix <- map["dj_remix"]
        dj_remix_status <- map["dj_remix_status"]
        dj_remix_currency <- map["dj_remix_currency"]
        dj_remix_price <- map["dj_remix_price"]
    }
}

class ProfileDataModel : Mappable{
    var userid: NSNumber?
    var name: String?
    var username: String?
    var email: String?
    var phone_number: String?
    var bio: String?
    var profile_picture: String?
    var background_image: String?
    var facebook_link: String?
    var twitter_link: String?
    var instagram_link: String?
    var youtube_link: String?
    var genre: String?
    var genre_ids: String?
    var dj_type: String?
    var user_type: String?
    var current_date: String?
    var join_date: String?
    var city: String?
    var state: String?
    var state_code: String?
    var country: String?
    var postalcode: String?
    var latitude: String?
    var longitude: String?
    var dj_feedback_drops: [feedBackDropDetail]?
    var media_audio_name: String?
    var media_audio: String?
    var media_audio_by: String?
    var media_audio_genre: String?
    var isProfileComplete: String?
    var is_favorite: String?
    var is_audio: String?
    var is_video: String?
    var project_remaining_time: String?
    var is_verified: String?
    var media_video_name: String?
    var media_video: String?
    var media_video_by: String?
    var media_video_genre: String?
    var media_video_project: String?
    var dj_recentData: [recentDataDetail]?
    var media_ending: String?
    var media_audio_profile: String?
    var media_video_id: NSNumber?
    var media_broadcastID: String?
    var register_type: String?
    
    var servciceCity: String?
    var serviceCountry: String?
    var serviceLat: String?
    var ServiceLong: String?
    var srtipe_token: String?
    var stripe_status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        phone_number <- map["phone_number"]
        bio <- map["bio"]
        profile_picture <- map["profile_picture"]
        background_image <- map["background_image"]
        facebook_link <- map["facebook_link"]
        twitter_link <- map["twitter_link"]
        instagram_link <- map["instagram_link"]
        youtube_link <- map["youtube_link"]
        genre <- map["genre"]
        genre_ids <- map["genre_ids"]
        dj_type <- map["dj_type"]
        user_type <- map["user_type"]
        current_date <- map["current_date"]
        join_date <- map["join_date"]
        city <- map["city"]
        state <- map["state"]
        state_code <- map["state_code"]
        country <- map["country"]
        postalcode <- map["postalcode"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        dj_feedback_drops <- map["dj_feedback_drops"]
        media_audio_name <- map["media_audio_name"]
        media_audio <- map["media_audio"]
        isProfileComplete <- map["isProfileComplete"]
        is_favorite <- map["is_favorite"]
        is_audio <- map["is_audio"]
        is_video <- map["is_video"]
        project_remaining_time <- map["project_remaining_time"]
        is_verified <- map["is_verified"]
        media_video_name <- map["media_video_name"]
        media_video <- map["media_video"]
        dj_recentData <- map["dj_recentData"]
        media_audio_by <- map["media_audio_by"]
        media_audio_genre <- map["media_audio_genre"]
        media_video_by <- map["media_video_by"]
        media_video_genre <- map["media_video_genre"]
        media_video_project <- map["media_video_project"]
        media_ending <- map["media_ending"]
        media_audio_profile <- map["media_audio_profile"]
        media_video_id <- map["media_video_id"]
        media_broadcastID <- map["media_broadcastID"]
        register_type <- map["register_type"]
        
        servciceCity <- map["servciceCity"]
        serviceCountry <- map["serviceCountry"]
        serviceLat <- map["serviceLat"]
        ServiceLong <- map["ServiceLong"]
        srtipe_token <- map["srtipe_token"]
        stripe_status <- map["stripe_status"]
    }
    
}

class GetProfileModel: Mappable {
    var success: NSNumber?
    var message: String?
    var Profiledata: [ProfileDataModel]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        Profiledata <- map["Profiledata"]
    }
}
