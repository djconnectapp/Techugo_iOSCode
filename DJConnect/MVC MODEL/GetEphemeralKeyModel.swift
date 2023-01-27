//
//  GetEphemeralKeyModel.swift
//  DJConnect
//
//  Created by Techugo on 17/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Foundation

struct GetEphemeralKeyModel: Codable {
    let id: String?
    let object: String?
    let secret: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case secret = "secret"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? (values.decodeIfPresent(String.self,forKey: .id))
        object = try? (values.decodeIfPresent(String.self,forKey: .object))
        secret = try? (values.decodeIfPresent(String.self,forKey: .secret))
    }
}
