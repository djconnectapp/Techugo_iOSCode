//
//  GetAccountListModel.swift
//  DJConnect
//
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class GetAccountListModelDetail: Mappable{
    var id: String?
    var account_no: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        account_no <- map["account_no"]
    }
    
    
}

class GetAccountListModel: Mappable{
    var success: NSNumber?
    var message: String?
    var result: [GetAccountListModelDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
    
    
}
