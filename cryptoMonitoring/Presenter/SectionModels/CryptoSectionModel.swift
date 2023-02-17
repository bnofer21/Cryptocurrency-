//
//  CryptoSectionModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

final class CryptoSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    
    init(_ coins: [Coin]) {
        rows = [CellIdentifiable]()
        coins.forEach({
            rows.append(CryptoBaseInfoCellModel($0))
        })
    }
}
