//
//  GetPromocodeModel.swift
//  DJConnect
//
//  Created by mac on 07/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class SetPromocodeModelDetail: Mappable{
    var coupon_code: String?
    var coupon_qty: String?
    var coupon_name: String?
    var description: String?
    var users: String?
    var used_users: String?
    var exp_date: String?
    var is_connect_case: Int?
    var is_commition: Int?
    var is_transaction: Int?
    var is_expired: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        coupon_code <- map["coupon_code"]
        coupon_qty <- map["coupon_qty"]
        coupon_name <- map["coupon_name"]
        description <- map["description"]
        users <- map["users"]
        exp_date <- map["exp_date"]
        used_users <- map["used_users"]
        is_connect_case <- map["is_connect_case"]
        is_commition <- map["is_commition"]
        is_transaction <- map["is_transaction"]
        is_expired <- map["is_expired"]
    }
}

class SetPromocodeModel: Mappable{
    var success: NSNumber?
    var message: String?
    var result: SetPromocodeModelDetail?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
}
