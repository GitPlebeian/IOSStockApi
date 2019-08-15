//
//  StockDataViewController.swift
//  stocksApi
//
//  Created by Jackson Tubbs on 8/15/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class StockDataViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet var toDateDatePicker: UIDatePicker!
    @IBOutlet var fromDateDatePicker: UIDatePicker!
    @IBOutlet weak var tickerSearchSearchBar: UISearchBar!
    // Output Outlets
    @IBOutlet weak var stockSymbol: UILabel!
    @IBOutlet weak var stockLastLabel: UILabel!
    @IBOutlet weak var stockAveragePriceLabel: UILabel!
    @IBOutlet weak var stockHighLabel: UILabel!
    @IBOutlet weak var stockLowLabel: UILabel!
    // Used to hide
    @IBOutlet weak var outputStackView: UIStackView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fromDateTextField.inputView = fromDateDatePicker
        toDateTextField.inputView = toDateDatePicker
    }
    
    // MARK: - Actions
    
    @IBAction func mainViewTapped(_ sender: Any) {
        fromDateTextField.resignFirstResponder()
        toDateTextField.resignFirstResponder()
    }
    
    @IBAction func toDatePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        toDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func fromDatePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        fromDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func getDataButtonTapped(_ sender: Any) {
        guard let ticker = tickerSearchSearchBar.text,
        let toDate = toDateTextField.text,
            let fromDate = fromDateTextField.text else {return}
        
        if ticker.isEmpty || toDate.isEmpty || fromDate.isEmpty {
            return
        }
        
        StockDataController.fetchStockData(searchTicker: ticker, fromDate: fromDate, toDate: toDate) { (stockReport) in
            guard let stockReport = stockReport else {return}
            
            DispatchQueue.main.async {
                self.stockSymbol.text = stockReport.symbol
                self.stockLastLabel.text = "Last: \(stockReport.last)"
                self.stockHighLabel.text = "High: \(stockReport.high)"
                self.stockAveragePriceLabel.text = "Average Price:  \(stockReport.averagePrice)"
                self.stockLowLabel.text = "Low: \(stockReport.low)"
                self.tickerSearchSearchBar.text = ""
                self.fromDateTextField.text = ""
                self.toDateTextField.text = ""
                self.outputStackView.isHidden = false
            }
        }
    }
} // End Of Class
