//
//  BuyOfferStep1Model.swift
//  DJConnect
//
//  Created by mac on 17/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class BuyOfferStep1ModelDetail: Mappable{
    var project_price: String?
    var transaction_fees: String?
    var currency_convert_charge: String?
    var total_price: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        project_price <- map["project_price"]
        transaction_fees <- map["transaction_fees"]
        currency_convert_charge <- map["currency_convert_charge"]
        total_price <- map["total_price"]
    }
    
    
}

class BuyOfferStep1Model: Mappable{
    var success: NSNumber?
    var message: String?
    var result: BuyOfferStep1ModelDetail?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
        
    }
    
    
}
