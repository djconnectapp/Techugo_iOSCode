//
//  DjTransactionListModel.swift
//  DJConnect
//
//  Created by mac on 04/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class DjTransDetail: Mappable{
    var id: String?
    var dj_id: Int?
    var request_date: String?
    var amount: String?
    var approve_date: String?
    var status: String?
    var note: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        dj_id <- map["dj_id"]
        request_date <- map["request_date"]
        amount <- map["amount"]
        approve_date <- map["approve_date"]
        status <- map["status"]
        note <- map["note"]
    }
    
    
}

class DjTransactionListModel: Mappable {
    var success: NSNumber?
    var message: String?
    var result: [DjTransDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
    

}
