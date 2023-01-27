//
//  buyProjectAudioModel.swift
//  DJConnect
//
//  Created by mac on 24/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class buyProjaudioDataDetail: Mappable{
    var audio_name: String?
    var audio_file: String?
    var closing_time: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audio_name <- map["audio_name"]
        audio_file <- map["audio_file"]
        closing_time <- map["closing_time"]
    }
    

}

class buyProjectAudioModel: Mappable{
    var success: NSNumber?
    var message: String?
    var audioData: buyProjaudioDataDetail?
    required init?(map: Map) {
       
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        audioData <- map["audioData"]
    }
    
    
}
