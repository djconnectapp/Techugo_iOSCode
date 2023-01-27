//
//  GetProjectTypeList.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 14/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class projectTypeDataDetail: Mappable{
    var project_type_id: NSNumber?
    var project_type: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        project_type_id <- map["project_type_id"]
        project_type <- map["project_type"]
    }
    
}

class GetProjectTypeList: Mappable {
    var success: NSNumber?
    var message: String?
    var projectTypeData: [projectTypeDataDetail]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        projectTypeData <- map["result"]
    }
 
}
