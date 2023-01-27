//
//  BuyDjTransHistModel.swift
//  DJConnect
//
//  Created by mac on 27/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class DjTransHistArDetail: Mappable{
    var artist_id: Int?
    var artist_name: String?
    var original_cost: String?
    var totalcost_transactionfees: Int?
    var is_offer: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        artist_id <- map["artist_id"]
        artist_name <- map["artist_name"]
        original_cost <- map["original_cost"]
        totalcost_transactionfees <- map["totalcost_transactionfees"]
        is_offer <- map["is_offer"]
    }
    
    
}

class BuyDjTransProjDetail: Mappable{
    var id: Int?
    var dj_name: String?
    var dj_image: String?
    var ar_currency: String?
    var project_name: String?
    var original_cost: String?
    var is_offer: String?
    var verify_count: Int?
    var rating_count: Int?
    var posted_date: String?
    var video_verify_date: String?
    var starting_balance: Int?
    var current_balance: String?
    var total_earned: String?
    var applyed_artist: [DjTransHistArDetail]?
    var amount: String?
    var approve_status: String?
    var approve_date: String?
    var account_no: String?
    var type: String?
    var ending_balance: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        dj_name <- map["dj_name"]
        dj_image <- map["dj_image"]
        ar_currency <- map["ar_currency"]
        project_name <- map["project_name"]
        original_cost <- map["original_cost"]
        is_offer <- map["is_offer"]
        verify_count <- map["verify_count"]
        rating_count <- map["rating_count"]
        applyed_artist <- map["applyed_artist"]
        posted_date <- map["posted_date"]
        video_verify_date <- map["video_verify_date"]
        starting_balance <- map["starting_balance"]
        current_balance <- map["current_balance"]
        total_earned <- map["total_earned"]
        amount <- map["amount"]
        approve_status <- map["approve_status"]
        approve_date <- map["approve_date"]
        account_no <- map["account_no"]
        type <- map["type"]
        ending_balance <- map["ending_balance"]
    }
    
}

class BuyDjTransHistModel: Mappable{
    var success: NSNumber?
    var message: String?
    var projects: [BuyDjTransProjDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projects <- map["projects"]
    }
}
