//
//  SecondViewModel.swift
//  CurrenciesConverter
//
//  Created by Rita on 10.01.2022.
//

import Foundation

class SecondViewModel {
    
    let currency: [Currency]
    
    init(currency: [Currency]) {
        self.currency = currency
    }
    
    func calculate(rate1: Double, rate2: Double, value: Double) -> Double {
        let result = rate1 * value / rate2
        return result
    }
    
    func getDefaultRate() -> Double {
        currency[0].rate
    }
    
    func getFirst() -> String? {
        currency.first?.cc
    }
    
    func numberOfElement() -> Int {
        currency.count
    }
    
    func rowCc(index: Int) -> String {
        currency[index].cc
    }
    
    func rowRate(index: Int) -> Double {
        currency[index].rate
    }
}
