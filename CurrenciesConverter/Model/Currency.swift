//
//  Model.swift
//  CurrenciesConverter
//
//  Created by Rita on 28.12.2021.
//

import Foundation

struct Currency: Decodable {
    let rate: Double
    let cc: String
}
