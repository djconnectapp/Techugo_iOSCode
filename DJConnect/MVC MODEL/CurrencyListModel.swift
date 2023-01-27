//
//  CurrencyListModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 13/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrencyDataDetail: Mappable{
    var currency_id: Int?
    var currency_name: String?
    var currency_symbol: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        currency_id <- map["currency_id"]
        currency_name <- map["currency_name"]
        currency_symbol <- map["currency_symbol"]
    }
 
}

class CurrencyListModel: Mappable {
    var success: NSNumber?
    var message: String?
    var currencyData: [CurrencyDataDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        currencyData <- map["currencyData"]
    }

}
