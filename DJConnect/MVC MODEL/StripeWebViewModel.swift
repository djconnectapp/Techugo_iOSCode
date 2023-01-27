//
//  StripeWebViewModel.swift
//  DJConnect
//
//  Created by Techugo on 01/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class StripeWebViewModel: Mappable {
    var success: NSNumber?
    var message: String?
    var stripe: stripeData?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        stripe <- map["stripe"]
    }
}

class stripeData: Mappable{
    var object: String?
    var url: String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        object <- map["object"]
        url <- map["url"]
        
    }
}
