//
//  CheckUserVerifyModel.swift
//  DJConnect
//
//  Created by Techugo on 01/02/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class CheckUserVerifyModel: Mappable {
    var success: NSNumber?
    var message: String?
    
    var userdata: userdata?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userdata <- map["userdata"]
    }
}

class userdata : Mappable {
    
    var admin_verify : String!
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        admin_verify <- map["admin_verify"]
        
    }
    
}

