//
//  NetworkManager.swift
//  CurrenciesConverter
//
//  Created by Rita on 28.12.2021.
//

import Foundation

class NetworkManager {
    
    func fetchData(url: String, completion: @escaping (_ answer: [Model])->()) {
        
        let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let apiResponse = try JSONDecoder().decode([Model].self, from: data)
                let answers = apiResponse
                completion(answers)
            } catch let error {
                print("error json \(error)")
            }
            
        }.resume()
    }
}
