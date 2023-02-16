//
//  CryptoSectionModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

class CryptoSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    
    init(_ coins: [Coin]) {
        rows = [CellIdentifiable]()
        coins.forEach({
            rows.append(CryptoBaseInfoCellModel($0))
        })
    }
}
