//
//  CryptoBaseInfoCellModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

class CryptoBaseInfoCellModel: CryptoBaseCellModel {
    override var cellIdentifier: String {
        return "CryptoBaseInfoCell"
    }
    
    var ticker: String
    var fullName: String
    var price: Double?
    var moneyType: Int
    var iconUrl: String?
    
    init(_ coin: Coin) {
        ticker = coin.ticker
        fullName = coin.fullName
        price = coin.price
        moneyType = coin.moneyType
        super.init()
        iconUrl = urlFromId(coin.idIcon)
    }
    
    private func urlFromId(_ id: String?) -> String {
        guard let id = id else { return "" }
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = id.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        return urlString
    }
    
    
}
