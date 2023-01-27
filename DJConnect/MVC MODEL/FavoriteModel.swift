//
//  FavoriteModel.swift
//  DJConnect
//
//  Created by My Mac on 11/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import  ObjectMapper

class FavoriteData: Mappable{
    var userid: Int?
    var name: String?
    var profile_pic: String?
    var projectid: Int?
    required init?(map: Map) {
           
    }
       
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["username"]
        profile_pic <- map["profile_pic"]
        projectid <- map["projectid"]
    }
}

class FavoriteModel: Mappable {
    
    var success: NSNumber?
    var message: String?
    var userData: [FavoriteData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userData <- map["result"]
    }
}

class FavoriteProjData: Mappable{
    var userid: Int?
    var name: String?
    var profile_pic: String?
    var projectid: Int?
    required init?(map: Map) {
           
    }
       
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["project_name"]
        profile_pic <- map["project_image"]
        projectid <- map["projectid"]
    }
}

class FavoriteProjModel: Mappable {
    
    var success: NSNumber?
    var message: String?
    var userData: [FavoriteProjData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userData <- map["result"]
    }
}
