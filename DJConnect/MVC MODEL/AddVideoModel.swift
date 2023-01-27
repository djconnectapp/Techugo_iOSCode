//
//  AddVideoModel.swift
//  DJConnect
//
//  Created by mac on 31/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class videoDataDetail: Mappable{
    var title: String?
    var content: String?
    var video: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
        video <- map["video"]
    }
    
    
}

class AddVideoModel: Mappable {
    var success: NSNumber?
    var message: String?
    var ResponseData: videoDataDetail?
    required init?(map: Map) {
      
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        ResponseData <- map["ResponseData"]
    }
    

   
}
