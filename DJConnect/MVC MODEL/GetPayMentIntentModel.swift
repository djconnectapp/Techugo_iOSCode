//
//  GetPayMentIntentModel.swift
//  DJConnect
//
//  Created by Techugo on 17/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Foundation

struct GetPayMentIntentModel: Codable {
    let amount: String?
    let id: String?
    let object: String?
    let client_secret: String?
    let currency: String?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case id = "id"
        case object = "object"
        case client_secret = "client_secret"
        case currency = "currency"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try? (values.decodeIfPresent(String.self,forKey: .amount))
        id = try? (values.decodeIfPresent(String.self,forKey: .id))
        object = try? (values.decodeIfPresent(String.self,forKey: .object))
        client_secret = try? (values.decodeIfPresent(String.self,forKey: .client_secret))
        currency = try? (values.decodeIfPresent(String.self,forKey: .currency))
    }
}

