//
//  EditProfileModel.swift
//  DJConnect
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class EditProfileModel: Mappable {
    
    var success: NSNumber?
    var message: String?
    var profile_picture: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        profile_picture <- map["profile_picture"]
    }
}

