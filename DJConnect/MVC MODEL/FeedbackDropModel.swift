//
//  FeedbackDropModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 05/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class FeedbackDropDetail: Mappable{
    var dj_id: Int?
    var dj_feedback: String?
    var dj_feedback_currency: String?
    var dj_feedback_price: String?
    var dj_drops: String?
    var dj_drops_currency: String?
    var dj_drops_price: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dj_id <- map["dj_id"]
        dj_feedback <- map["dj_feedback"]
        dj_feedback_currency <- map["dj_feedback_currency"]
        dj_feedback_price <- map["dj_feedback_price"]
        dj_drops <- map["dj_drops"]
        dj_drops_currency <- map["dj_drops_currency"]
        dj_drops_price <- map["dj_drops_price"]
    }
    
    
}

class FeedbackDropModel: Mappable {
    var success: NSNumber?
    var message: String?
    var DjFeedbackDropsData: [FeedbackDropDetail]?
    required init?(map: Map) {
      
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        DjFeedbackDropsData <- map["DjFeedbackDropsData"]
    }
    
    
    
}
