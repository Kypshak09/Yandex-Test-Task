//
//  PriceModel.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 30.01.2023.
//

import Foundation

struct PriceModel: Codable {
    let responce: [Price]
}
struct Price: Codable {
    let c: String
    let ch: String
    let cp: String
}
