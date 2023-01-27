//
//  BuyOfferTransHistModel.swift
//  DJConnect
//
//  Created by mac on 25/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class BuyTransProjDetail: Mappable{
    var id: Int?
    var is_offer: Int?
    var purchased_date: String?
    var dj_name: String?
    var dj_image: String?
    var project_name: String?
    var add_video_date: String?
    var project_price: String?
//    var totalcost_transactionfees: Int?
    var totalcost_transactionfees: String?
    var before_apply: String?
    var after_apply: String?
    var is_video_verify: Int?
    var is_rating: Int?
    var ar_currency: String?
    var ar_name: String?
    var ar_image: String?
    var amount: String?
    var account_no: String?
    var type: String?
    var song_status: Int?
    var offer_cost: String?
    var dj_id: Int?
    var project_id: Int?
    var song_status_reason: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        is_offer <- map["is_offer"]
        purchased_date <- map["purchased_date"]
        dj_name <- map["dj_name"]
        dj_image <- map["dj_image"]
        project_name <- map["project_name"]
        add_video_date <- map["add_video_date"]
        project_price <- map["project_price"]
        totalcost_transactionfees <- map["totalcost_transactionfees"]
        before_apply <- map["before_apply"]
        after_apply <- map["after_apply"]
        is_video_verify <- map["is_video_verify"]
        is_rating <- map["is_rating"]
        ar_currency <- map["ar_currency"]
        ar_name <- map["ar_name"]
        ar_image <- map["ar_image"]
        amount <- map["amount"]
        account_no <- map["account_no"]
        type <- map["type"]
        song_status <- map["song_status"]
        offer_cost <- map["offer_cost"]
        dj_id <- map["dj_id"]
        project_id <- map["project_id"]
        song_status_reason <- map["song_status_reason"]
    }
    
    
}

class BuyOfferTransHistModel: Mappable{
    var success: NSNumber?
    var message: String?
    var projects: [BuyTransProjDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projects <- map["projects"]
    }
    
    
}
