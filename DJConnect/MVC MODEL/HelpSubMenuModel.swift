//
//  HelpSubMenuModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 21/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class helpDataDetail: Mappable{
    var title: String?
    var content: String?
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
    
}

class HelpSubMenuModel: Mappable {
    var success: NSNumber?
    var message: String?
    var helpData: helpDataDetail?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        helpData <- map["result"]
    }
    
}
