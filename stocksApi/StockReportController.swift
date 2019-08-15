//
//  StockReportController.swift
//  stocksApi
//
//  Created by Jackson Tubbs on 8/15/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

class StockReportController {
    
    static var report: StockReport?
    
    static func getReportForStockData(stockData: StockData) -> StockReport{
        
        let averagePrice = calculateAveragePrice(stockDays: stockData.results)
        let highestPrice = calculateHigh(stockDays: stockData.results)
        let lowestPrice = calculateLow(stockDays: stockData.results)
        let last = stockData.results[stockData.results.count - 1].close
        
        return StockReport(symbol: stockData.ticker, averagePrice: averagePrice, high: highestPrice, low: lowestPrice, last: last)
    }
    
    private static func calculateAveragePrice(stockDays: [StockDay]) -> Double {
        var totalOfPrices: Double = 0
        for stockDay in stockDays {
            totalOfPrices += stockDay.close
        }
        return totalOfPrices / Double(stockDays.count)
    }
    
    private static func calculateHigh(stockDays: [StockDay]) -> Double {
        var highestPrice: Double = 0
        for stockDay in stockDays {
            if stockDay.high > highestPrice {
                highestPrice = stockDay.high
            }
        }
        return highestPrice
    }
    
    private static func calculateLow(stockDays: [StockDay]) -> Double {
        guard stockDays.count > 0 else {return -1}
        var lowestPrice = stockDays[0].low
        for stockDay in stockDays {
            if stockDay.low < lowestPrice {
                lowestPrice = stockDay.low
            }
        }
        return lowestPrice
    }
}
