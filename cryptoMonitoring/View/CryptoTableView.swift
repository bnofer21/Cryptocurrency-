//
//  CryptoTableView.swift
//  cryptoMonitoring
//
//  Created by Юрий on 15.12.2022.
//

import UIKit

class CryptoTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(CryptoBaseInfoCell.self, forCellReuseIdentifier: "CryptoBaseInfoCell")
        register(CryptoTableHeader.self, forHeaderFooterViewReuseIdentifier: CryptoTableHeader.id)
        sectionHeaderTopPadding = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
