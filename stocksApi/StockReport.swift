//
//  StockReport.swift
//  stocksApi
//
//  Created by Jackson Tubbs on 8/15/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

class StockReport {
    
    let symbol: String
    let averagePrice: Double
    let high: Double
    let low: Double
    let last: Double
    
    init(symbol: String, averagePrice: Double, high: Double, low: Double, last: Double) {
        self.symbol = symbol
        self.averagePrice = averagePrice
        self.high = high
        self.low = low
        self.last = last
    }
}
