//
//  AppleSucessModel.swift
//  DJConnect
//
//  Created by Techugo on 12/10/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class AppleDetailsModel: Mappable{
    var token : String!
    var userid : Int!
    var profile_completion : String!
    var currency_code : String!
    var currncyName : String!
    var currncySymbol : String!
    var userPin : Int!
    var NotificationCount : Int!
    var project_remaining_time : String!
    var genre : String!
    var currncyId : Int!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        userid <- map["userid"]
        profile_completion <- map["profile_completion"]
        currency_code <- map["currency_code"]
        currncyName <- map["currncyName"]
        currncySymbol <- map["currncySymbol"]
        userPin <- map["userPin"]
        NotificationCount <- map["NotificationCount"]
        project_remaining_time <- map["project_remaining_time"]
        genre <- map["genre"]
        currncyId <- map["currncyId"]
    }
}

class AppleSucessModel: Mappable {
    var success: Int?
    var message: String?
    var responseData: GoogleDetailsModel?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["result"]
    }
}
