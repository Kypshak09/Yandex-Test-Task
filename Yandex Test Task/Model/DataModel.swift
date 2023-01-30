//
//  Models.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 30.01.2023.
//

import Foundation

struct DataModel: Codable {
    let response: [Stocks]
}

struct Stocks: Codable {
    let name: String
    let short_name: String
    
}
