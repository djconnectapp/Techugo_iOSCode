//
//  AlertModel.swift
//  DJConnect
//
//  Created by mac on 18/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class AlertNewNotifyDetails: Mappable{
    var id: Int?
    var sender: String?
    var is_read: Int?
    var type: String?
    var message: String?
    var sender_id: Int?
    var receiver_id: Int?
    var title: String?
    var create_date: String?
    var broadcastID: String?
    var project_id: Int?
    var id_for_verify: Int?
    var video_type: String?
    var isOffer: Int?
    var video_id: Int?
    var song_review_id: Int?
    var verify_status: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        sender <- map["sender"]
        is_read <- map["is_read"]
        type <- map["type"]
        message <- map["message"]
        sender_id <- map["sender_id"]
        receiver_id <- map["receiver_id"]
        title <- map["title"]
        create_date <- map["create_date"]
        broadcastID <- map["broadcastID"]
        project_id <- map["project_id"]
        id_for_verify <- map["id_for_verify"]
        video_type <- map["video_type"]
        isOffer <- map["isOffer"]
        video_id <- map["video_id"]
        song_review_id <- map["song_review_id"]
        verify_status <- map["verify_status"]
        
        
    }
    
    
}

class AlertModel: Mappable{
    var success: NSNumber?
    var message: String?
    var newData: [AlertNewNotifyDetails]?
    var viewData: [AlertNewNotifyDetails]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        newData <- map["newData"]
        viewData <- map["viewData"]
    }
    
}
