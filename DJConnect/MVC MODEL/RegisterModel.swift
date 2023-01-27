//
//  RegisterModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterModel: Mappable {
    var success: NSNumber?
    var message: String?
    var token: String?
    var userid: NSNumber?
    var username: String?
    var country_code: String?
    var currencyId : NSNumber?
    var currncyName : String?
    var currncySymbol: String?
    var userPin : String?
    var genre : String?
    var NotificationCount : NSNumber?
    var project_remaining_time : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        token <- map["token"]
        userid <- map["userid"]
        username <- map["username"]
        country_code <- map["country_code"]
        currencyId <- map["currencyId"]
        currncyName <- map["currncyName"]
        currncySymbol <- map["currncySymbol"]
        userPin <- map["userPin"]
        NotificationCount <- map["NotificationCount"]
        project_remaining_time <- map["project_remaining_time"]
        genre <- map["genre"]
    }
}
