//
//  MainViewModel.swift
//  CurrenciesConverter
//
//  Created by Rita on 10.01.2022.
//

import Foundation

class MainViewModel {
    
    var callback: (() -> Void)?
    
    private var currencies = [Currency]()
    private let networkManager: NetworkManager
    private let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        apiResponse()
    }
    
    func numberOfElement() -> Int {
        currencies.count
    }
    
    func rowCc(index: Int) -> String {
        currencies[index].cc
    }
    
    func rowRate(index: Int) -> Double {
        currencies[index].rate
    }
    
    func apiResponse() {
        networkManager.fetchData(url: urlString) { (answer) in
            self.currencies = answer
            self.filter()
            self.callback?()
        }
    }
    
    func filter() {
        currencies = currencies.filter({ (currency) -> Bool in
            if currency.cc == "USD" || currency.cc == "EUR" {
                return true
            } else {
                return false
            }
        })
    }
    
    func createSecondViewModel() -> SecondViewModel {
        
        var array = currencies
        array.insert(Currency(rate: 1.0, cc: "UAH"), at: 0)
        
        return SecondViewModel(currency: array)
    }
}
