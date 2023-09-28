//
//  MessageResponseModel.swift
//  LawJerry
//
//  Created by Lê Đình Linh on 25/09/2023.
//

import Foundation

struct LawJerryResponseModel: Decodable {
    let answer: String?

    enum CodingKeys: String, CodingKey {
        case answer = "answer:"
    }
}
