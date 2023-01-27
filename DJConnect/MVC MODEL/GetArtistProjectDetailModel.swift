//
//  GetArtistProjectDetailModel.swift
//  DJConnect
//
//  Created by mac on 04/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class artistRejectSongListDetail: Mappable{
    var audio_title: String?
    var audio: String?
    var applied_date: String?
    var audio_status: String?
    var reason: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_title <- map["audio_title"]
        audio <- map["audio"]
        applied_date <- map["applied_date"]
        audio_status <- map["audio_status"]
        reason <- map["reason"]
    }
    
    
}

class artistAppiledSongDetail: Mappable{
    var artistid: Int?
    var artistname: String?
    var profilepicture: String?
    var audioname: String?
    var audiofile: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        artistid <- map["artistid"]
        artistname <- map["artistname"]
        profilepicture <- map["profilepicture"]
        audioname <- map["audioname"]
        audiofile <- map["audiofile"]
    }
    
    
}

class artistAppliedProjSongStatus: Mappable{
    var audio_title: String?
    var audio: String?
    var applied_date: String?
    var audio_status: String?
    var reason: String?
    var artist_list: [artistAppiledSongDetail]?
    var rejectData: [artistRejectSongListDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_title <- map["audio_title"]
        audio <- map["audio"]
        applied_date <- map["applied_date"]
        audio_status <- map["audio_status"]
        reason <- map["reason"]
        artist_list <- map["artist_list"]
        rejectData <- map["rejectData"]
    }
    
    
    
}

class GetArtistProjectDetailModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responseData: [artistAppliedProjSongStatus]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["responseData"]
    }
    

  

}
