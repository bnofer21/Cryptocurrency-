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
    var idIcon: String?
    
    init(_ coin: Coin) {
        ticker = coin.ticker
        fullName = coin.fullName
        price = coin.price
        moneyType = coin.moneyType
        idIcon = coin.idIcon
    }
    
    
}
