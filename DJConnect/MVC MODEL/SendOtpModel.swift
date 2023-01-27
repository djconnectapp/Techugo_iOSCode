//
//  SendOtpModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 23/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class VerifyData: Mappable{
    var phone_number: String?
    var otp_code: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        phone_number <- map["phone_number"]
        otp_code <- map["otp_code"]
    }
}

class SendOtpModel: Mappable{
    var success: NSNumber?
    var message: String?
    var responseData: VerifyData?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        responseData <- map["responseData"]
    }
}
