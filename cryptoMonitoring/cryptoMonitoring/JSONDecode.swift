//
//  JSONDecode.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation

let urlString = "https://rest.coinapi.io/v1/assets?apikey=87F2B9A6-992C-4212-ADAC-190444275DA9"
var resultsReturn = [Coin]()

func getData() {
    let url = URL(string: urlString)
    if let url = url {
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([Coin].self, from: data)
                resultsReturn = results
                print("in JSONDecode: \(resultsReturn.count)")
            } catch {
                print(error)
            }
        }.resume()
    }
}

