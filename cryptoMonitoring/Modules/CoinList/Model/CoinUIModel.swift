//
//  CoinUIModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation

struct CoinUIModel: Hashable {
    
    // MARK: - Properties
    
    let id: String
    let type: CoinType
    let ticker: String
    let name: String
    let price: String
    let image: String
}
