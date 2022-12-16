//
//  JSONDecode.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getData(completion: @escaping([Coin])->Void) {
        let urlString = "https://rest.coinapi.io/v1/assets?apikey=DE69ED22-17F3-46ED-83E2-8196394EBCFA"
        let url = URL(string: urlString)
        guard let url = url else { return }
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([Coin].self, from: data)
                    completion(results)
                } catch {
                    print(error)
                }
            }.resume()
    }
    
    func getImageUrl(id: String) -> URL {
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = id.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        let url = URL(string: urlString)
        return url!
    }
}




