//
//  StockData.swift
//  stocksApi
//
//  Created by Jackson Tubbs on 8/15/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

struct StockData: Decodable {
    
//    let companyName: String?
    let ticker: String
    let results: [StockDay]
}

// MARK: - Second Level

struct StockDay: Decodable {
    
    let volume: Int
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let timeStamp: Int
    
    // Used for the key of the received data as to not get a big error
    private enum CodingKeys: String, CodingKey {
        case volume = "v"
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case timeStamp = "t"
    }
}
