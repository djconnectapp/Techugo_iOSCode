//
//  InAppPurchaseModel.swift
//  DJConnect
//
//  Created by Techugo on 09/06/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class InAppPurchaseModel: Mappable {
    var success: NSNumber?
    var message: String?
    var token: String?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        token <- map["token"]
    }
}

