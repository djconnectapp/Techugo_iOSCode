//
//  UserDeleteModel.swift
//  DJConnect
//
//  Created by Techugo on 09/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class UserDeleteModel: Mappable {
    var success: NSNumber?
    var message: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}
