//
//  ArtistReviewMapResponse.swift
//  DJConnect
//
//  Created by My Mac on 22/02/21.
//  Copyright © 2021 mac. All rights reserved.
//


import Foundation
import ObjectMapper

class ArtistReviewMapResponse : Mappable {
    
    var graphPinData : [ArtistReviewMapGraphPinData]!
    var message : String!
    var success : NSNumber!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        graphPinData <- map["graphPinData"]
        message <- map["message"]
        success <- map["success"]
    }
    
}
class ArtistReviewMapGraphPinData : Mappable{
    
    var djGenre : String!
    var djId : Int!
    var djIsVerified : Int!
    var djName : String!
    var latitude : String!
    var longitude : String!
    var profileImage : String!
    var songReiewId : Int!
    var songreviewCost : String!
    var totalStars : String!
    var totalUser : String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        djGenre <- map["dj_genre"]
        djId <- map["dj_id"]
        djIsVerified <- map["dj_is_verified"]
        djName <- map["dj_name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        profileImage <- map["profile_image"]
        songReiewId <- map["songReiewId"]
        songreviewCost <- map["songreview_cost"]
        totalStars <- map["total_stars"]
        totalUser <- map["total_user"]
    }
}

