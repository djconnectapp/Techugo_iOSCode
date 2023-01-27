//
//  CustomerModel.swift
//  DJConnect
//
//  Created by Techugo on 18/02/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerModel: Mappable {
    var success: NSNumber?
    var message: String?
    var id : String!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        id <- map["id"]
    }
}

