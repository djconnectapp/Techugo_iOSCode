//
//  DjTransactionListModel.swift
//  DJConnect
//
//  Created by mac on 04/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class ArTransDetail: Mappable{
    var id: String?
    var artistid: String?
    var order_date: String?
    var amount: String?
    var transction_id: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        artistid <- map["artistid"]
        order_date <- map["order_date"]
        amount <- map["amount"]
        transction_id <- map["transction_id"]
    }
    
    
}

class ArTransactionListModel: Mappable{
    var success: NSNumber?
    var message: String?
    var result: [ArTransDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
    
    
}
