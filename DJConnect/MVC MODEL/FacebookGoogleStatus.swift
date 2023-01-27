//
//  FacebookGoogleStatus.swift
//  DJConnect
//
//  Created by mac on 11/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import ObjectMapper
class FacebookGoogleStatusDetail: Mappable{
    var userid: String?
    var user_token: String?
    var registerStatus: String?
    var profile_completion: String?
    var currency_code: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        user_token <- map["token"]
        registerStatus <- map["registerStatus"]
        profile_completion <- map["profile_completion"]
        currency_code <- map["currency_code"]
    }
    
}

class FacebookGoogleStatusModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responceData: FacebookGoogleStatusDetail?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responceData <- map["responceData"]
    }
}
