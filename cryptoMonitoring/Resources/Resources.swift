//
//  Resources.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import Foundation

enum Resources {
    
    enum ShowCase {
        case search
        case def
        case filter
    }
    
    enum SelectButtons: String, CaseIterable {
        case all = "All"
        case fiat = "Fiat"
        case crypto = "Crypto"
    }
}
