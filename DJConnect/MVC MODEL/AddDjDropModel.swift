//
//  AddDjDropModel.swift
//  DJConnect
//
//  Created by mac on 25/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class djDropDataDetail: Mappable{
    var status: String?
    var closing_time: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        closing_time <- map["closing_time"]
    }

}

class AddDjDropModel: Mappable {
    var success: NSNumber?
    var message: String?
    var djDropData: djDropDataDetail?
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        djDropData <- map["djDropData"]
    }

}
