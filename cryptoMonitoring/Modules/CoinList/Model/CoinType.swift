//
//  CoinType.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation

enum CoinType: Int {
    case fiat = 0
    case crypto = 1
    case all
    
    // MARK: - Properties
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .crypto:
            return "Crypto"
        case .fiat:
            return "Fiat"
        }
    }
}
