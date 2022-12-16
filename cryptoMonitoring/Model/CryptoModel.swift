//
//  CryptoModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation

struct Coin: Decodable, Equatable {
    let ticker: String
    let fullName: String
    let price: Double?
    let moneyType: Int
    let idIcon: String?
    
    enum CodingKeys: String, CodingKey {
    case ticker = "asset_id"
    case fullName = "name"
    case price = "price_usd"
    case moneyType = "type_is_crypto"
    case idIcon = "id_icon"
    }
    
}


