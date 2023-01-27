//
//  FaceBookModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 31/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class FaceBookDetailsModel: Mappable{
    var token: String?
    var userid: NSNumber?
    var profile_completion: String?
    var currency_code: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        userid <- map["userid"]
        profile_completion <- map["profile_completion"]
        currency_code <- map["currency_code"]
    }
    
    
}
class FaceBookModel: Mappable {
    var success: NSNumber?
    var message: String?
    var token: String?
    var userid: NSNumber?
    var responceData: FaceBookDetailsModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        token <- map["token"]
        userid <- map["userid"]
        responceData <- map["responceData"]
    }
}


