//
//  GetNotifyModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 10/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class GetNotifyModel:  Mappable{
    var success: NSNumber?
    var message: String?
    var flag: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        flag <- map["flag"]
    }

}
