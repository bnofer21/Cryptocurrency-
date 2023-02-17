//
//  JSONDecode.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation

protocol CryptoLoaderInterface {
    func loadCrypto(completion: @escaping ([Coin]?, String?) -> Void)
}

final class CryptoLoaderService: CryptoLoaderInterface {
    
    func loadCrypto(completion: @escaping ([Coin]?, String?) -> Void) {
        let urlString = "https://rest.coinapi.io/v1/assets?apikey=DE69ED22-17F3-46ED-83E2-8196394EBCFA"
        let url = URL(string: urlString)
        guard let url = url else { return }
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                guard let data = data else {
                    completion(nil, "Error: No data found")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([Coin].self, from: data)
                    completion(results, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            }.resume()
    }
    
}




