//
//  CryptoBaseLoadingCellModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 18.02.2023.
//

import Foundation

class CryptoBaseLoadingCellModel: CryptoBaseCellModel {
    
    override var cellIdentifier: String {
        return "CryptoBaseLoadingCell"
    }
    
    var isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
}
