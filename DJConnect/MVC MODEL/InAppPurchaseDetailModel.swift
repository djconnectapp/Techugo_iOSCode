//
//  InAppPurchaseDetailModel.swift
//  DJConnect
//
//  Created by Techugo on 09/06/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class userSubscription : Mappable {

    var userid : NSNumber!
    var artist_type : String!
    var subscription_id : NSNumber!
    var subscription_expiry_date : String!
    var amount : String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        userid <- map["userid"]
        artist_type <- map["artist_type"]
        subscription_id <- map["subscription_id"]
        subscription_expiry_date <- map["subscription_expiry_date"]
        amount <- map["amount"]
    }
    
}

class InAppPurchaseDetailModel: Mappable {
    var success: NSNumber?
    var message: String?
    var userSubscription: userSubscription?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userSubscription <- map["userSubscription"]
    }
}
