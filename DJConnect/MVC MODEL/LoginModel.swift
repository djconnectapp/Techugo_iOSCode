//
//  LoginModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 22/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginData : Mappable {
    
    var birthdate : String!
    var countryCode : String!
    var currncyName : String!
    var currncySymbol : String!
    var email : String!
    var genre : String!
    var isForgot : String!
    var name : String!
    var notificationCount : Int!
    var phoneNumber : String!
    var profilePicture : String!
    var type : String!
    var userid : NSNumber!
    var username : String!
    var userPin : String!
    var currencyId : NSNumber!
    var project_remaining_time : String!
    var artist_type : String!
    var subscription_id : NSNumber!
    var subscription_expiry_date : String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        birthdate <- map["birthdate"]
        countryCode <- map["country_code"]
        currncyName <- map["currncyName"]
        currncySymbol <- map["currncySymbol"]
        email <- map["email"]
        genre <- map["genre"]
        isForgot <- map["is_forgot"]
        name <- map["name"]
        notificationCount <- map["NotificationCount"]
        phoneNumber <- map["phone_number"]
        profilePicture <- map["profilePicture"]
        type <- map["type"]
        userid <- map["userid"]
        username <- map["username"]
        userPin <- map["userPin"]
        currencyId <- map["currncyId"]
        project_remaining_time <- map["project_remaining_time"]
        artist_type <- map["artist_type"]
        subscription_id <- map["subscription_id"]
        subscription_expiry_date <- map["subscription_expiry_date"]
    }
    
}

class LoginModel: Mappable {
    var success: NSNumber?
    var message: String?
    var token: String?
    var responseData: LoginData?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        token <- map["token"]
        responseData <- map["responseData"]
    }
}
