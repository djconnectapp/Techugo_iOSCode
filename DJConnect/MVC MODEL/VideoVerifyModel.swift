//
//  VideoVerifyModel.swift
//  DJConnect
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper


class VideoVerifyModel : Mappable {
    
    var author : String!
    var clientVersion : String!
    var created : Int!
    var height : Int!
    var id : String!
    var ingestChannel : String!
    var length : Int!
    var preview : String!
    var resourceUri : String!
    var tags : [AnyObject]!
    var title : String!
    var type : String!
    var width : Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        clientVersion <- map["clientVersion"]
        created <- map["created"]
        height <- map["height"]
        id <- map["id"]
        ingestChannel <- map["ingestChannel"]
        length <- map["length"]
        preview <- map["preview"]
        resourceUri <- map["resourceUri"]
        tags <- map["tags"]
        title <- map["title"]
        type <- map["type"]
        width <- map["width"]
    }
    
}



