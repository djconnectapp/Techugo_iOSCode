//
//  GetCustomerModel.swift
//  DJConnect
//
//  Created by Techugo on 17/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Foundation

struct GetCustomerModel: Codable {
    let object: String?
    let data: [GetCustomerData]?
    let has_more: Bool?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case object = "object"
        case data = "data"
        case has_more = "has_more"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        object = try? (values.decodeIfPresent(String.self,forKey: .object))
        data = try? (values.decodeIfPresent([GetCustomerData].self,forKey: .data))
        has_more = try? (values.decodeIfPresent(Bool.self,forKey: .has_more))
        url = try? (values.decodeIfPresent(String.self,forKey: .url))
    }
}

struct GetCustomerData: Codable {
    let id: String?
    let object: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? (values.decodeIfPresent(String.self,forKey: .id))
        object = try? (values.decodeIfPresent(String.self,forKey: .object))

    }
}

