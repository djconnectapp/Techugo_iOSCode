//
//  VideoFormatMP4.swift
//  DJConnect
//
//  Created by My Mac on 29/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import ObjectMapper


class VideoChangeFormate: Mappable {
    
    var format: String?
    var progress: Int?
    var status: String?
    var url: AnyObject?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
    format <- map["format"]
    progress <- map["progress"]
    status <- map["status"]
    url <- map["url"]
    }
    
}
