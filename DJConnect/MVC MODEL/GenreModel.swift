//
//  GenreModel.swift
//  DJConnect
//
//  Created by My Mac on 04/02/20.
//  Copyright © 2020 mac. All rights reserved.
//



import UIKit
import ObjectMapper

class GenreData : Mappable {
    var id: Int?
    var title: String?
    var isSelected = false

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
      
    }
}

class GenreModel: Mappable {
    var success: NSNumber?
    var message: String?
    var genreList: [GenreData]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        genreList <- map["result"]
    }
}
