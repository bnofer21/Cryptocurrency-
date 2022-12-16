//
//  CryptoTableView.swift
//  cryptoMonitoring
//
//  Created by Юрий on 15.12.2022.
//

import UIKit

class CryptoTableView: UITableView {
    
    var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.id)
        register(CryptoTableHeader.self, forHeaderFooterViewReuseIdentifier: CryptoTableHeader.id)
        sectionHeaderTopPadding = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTarget(target: Any?, action: Selector) {
        cancelButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
