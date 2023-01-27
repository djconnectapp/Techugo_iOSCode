//
//  GetDjDropModel.swift
//  DJConnect
//
//  Created by mac on 27/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class userDjDataDropDetails: Mappable{
    var userid: Int?
    var name: String?
    var email: String?
    var bio: String?
    var profile_picture: String?
    var genre: String?
    var user_type: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["name"]
        email <- map["email"]
        bio <- map["bio"]
        profile_picture <- map["profile_picture"]
        genre <- map["genre"]
        user_type <- map["user_type"]
    }
    
    
}

class audioDropDetails: Mappable{
    var djdrop_id: String?
    var audio_name: String?
    var audio_file: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        djdrop_id <- map["djdrop_id"]
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
    }
    
}
class DjDropDetails: Mappable{
    var djdrop_id: String?
    var dj_drop_title: String?
    var dj_drop_des: String?
    var remaining_time: String?
    var status: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        djdrop_id <- map["djdrop_id"]
        dj_drop_title <- map["dj_drop_title"]
        remaining_time <- map["remaining_time"]
        dj_drop_des <- map["dj_drop_des"]
        status <- map["status"]
    }
    
}


class GetDjDropModel: Mappable {
    var success: NSNumber?
    var message: String?
    var DjDrop: DjDropDetails?
    var audio: audioDropDetails?
    var userDjData: userDjDataDropDetails?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        DjDrop <- map["DjDrop"]
        audio <- map["audio"]
        userDjData <- map["userDjData"]

        
    }
    

  

}
