//
//  CryptoBaseInfoCellModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

final class CryptoBaseInfoCellModel: CryptoBaseCellModel {
    override var cellIdentifier: String {
        return "CryptoBaseInfoCell"
    }
    
    var coin: Coin
    
    var ticker: String {
        return coin.ticker
    }
    var fullName: String {
        return coin.fullName
    }
    var price: String? {
        guard let price = coin.price else { return "" }
        var result = String(price)
        if price < 10 {
            result = String(format: "%.4f", price)
        } else if price > 10, price < 1000 {
            result = String(format: "%.2f", price)
        } else {
            result = String(format: "%.0f", price)
        }
        result.append(" $")
        return result
    }
    var moneyType: Int {
        return coin.moneyType
    }
    var iconUrl: String? {
        guard let id = coin.idIcon else { return "" }
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = id.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        return urlString
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
}
