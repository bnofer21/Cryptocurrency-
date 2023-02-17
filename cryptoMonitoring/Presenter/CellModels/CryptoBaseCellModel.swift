//
//  CryptoBaseCellModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

class CryptoBaseCellModel: CellIdentifiable {
    let automaticHeight: Float = -1
    
    var cellIdentifier: String {
        return ""
    }
    
    var cellHeight: Float {
        return automaticHeight
    }
}
