//
//  CellViewModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import Foundation

struct CellViewModel {
    
    var coin: Coin
    
    var ticker: String {
        return coin.ticker
    }
    
    var fullName: String {
        return coin.fullName
    }
    
    var price: String {
        guard let price = coin.price else { return "" }
        var result = String(format: "%.4f", price)
        result.append("$")
        return result
    }
    
    var type: Int {
        return coin.moneyType
    }
    
    var iconUrl: String {
        guard let id = coin.idIcon else { return "" }
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = id.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        return urlString
    }
    
    init(coin: Coin) {
        self.coin = coin
    }
}
