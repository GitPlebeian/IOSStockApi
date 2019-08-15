//
//  StockDataController.swift
//  stocksApi
//
//  Created by Jackson Tubbs on 8/15/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

class StockDataController {
    
    static func fetchStockData(searchTicker: String, fromDate: String, toDate: String, completion: @escaping (StockReport?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.polygon.io/v2") else {completion(nil); return}
        
        // Combine all ticker element
        var fullURL = baseURL
        fullURL.appendPathComponent("aggs")
        fullURL.appendPathComponent("ticker")
        fullURL.appendPathComponent(searchTicker.uppercased())
        fullURL.appendPathComponent("range")
        fullURL.appendPathComponent("1")
        fullURL.appendPathComponent("day")
        fullURL.appendPathComponent(fromDate)
        fullURL.appendPathComponent(toDate)
        print(fullURL.absoluteString)
        
        var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        let apiKeyQuery = URLQueryItem(name: "apiKey", value: "AKIWF2YRKXRBRI33YMLL")
        urlComponents?.queryItems = [apiKeyQuery]
        
        guard let finalURL = urlComponents?.url else {return}
        
        print(finalURL.absoluteString)
        
        URLSession.shared.dataTask(with: finalURL) { (data, urlResponse, error) in
            if let error = error {
                print("Error at \(#function) \nError \(error)\nErrorDescription \(error.localizedDescription)")
                if let urlResponse = urlResponse {
                    print("URL Response: \(urlResponse)")
                }
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let stockData = try decoder.decode(StockData.self, from: data)
                
                completion(StockReportController.getReportForStockData(stockData: stockData))
            } catch {
                print("Error at \(#function) Big ERROR: \(error)\nSmall Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }.resume()
    }
} // End Of Class
