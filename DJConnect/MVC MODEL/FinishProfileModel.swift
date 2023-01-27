//
//  FinishProfileModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 25/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class FinishProfileModel: Mappable {
    
    var success: NSNumber?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}
