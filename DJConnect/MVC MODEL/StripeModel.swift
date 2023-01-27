//
//  StripeModel.swift
//  DJConnect
//
//  Created by mac on 14/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class StripeModel: Mappable {
    
    var success: NSNumber?
    var message: String?
    var transaction_id: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        transaction_id <- map["transaction_id"]
    }
}
