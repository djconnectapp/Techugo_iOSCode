//
//  GetChangeRemainderModel.swift
//  DJConnect
//
//  Created by mac on 01/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class getRemainderDetails: Mappable{
    var c_time: String?
    var days: String?
    var onoff: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        c_time <- map["c_time"]
        days <- map["days"]
        onoff <- map["onoff"]
    }
    
    
}
class GetChangeRemainderModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responseData: [getRemainderDetails]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["result"]
    }
}
