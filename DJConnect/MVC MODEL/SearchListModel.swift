//
//  SearchListModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 11/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchListDetail: Mappable{
    var userid: Int?
    var name: String?
    var user_type: String?
    var serch_type: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        name <- map["username"]
        user_type <- map["user_type"]
        serch_type <- map["serch_type"]
    }
}

class SearchListModel: Mappable {
    var success: NSNumber?
    var message: String?
    var searchData: [SearchListDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        searchData <- map["searchData"]
    }
}
