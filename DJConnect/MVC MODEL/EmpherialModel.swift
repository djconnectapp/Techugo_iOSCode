//
//  EmpherialModel.swift
//  DJConnect
//
//  Created by Techugo on 21/02/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class EmpherialModel: Mappable {
    var success: NSNumber?
    var message: String?
    var responseData: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["key"]
    }
}
