//
//  ForgotPasswordModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 22/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgotPasswordModel: Mappable {
    var success: NSNumber?
    var message: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}
