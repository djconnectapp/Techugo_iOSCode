//
//  AddMediaModel.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 26/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class audioDataDetail: Mappable{
    var audio_name: String?
    var audio_file: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]

    }
}

class AddMediaModel: Mappable {
    var success: NSNumber?
    var message: String?
    var audioData: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        audioData <- map["audioData"]

    }
    

  

}
