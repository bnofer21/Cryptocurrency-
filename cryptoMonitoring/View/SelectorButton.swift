//
//  SelectorButton.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import UIKit

final class SelectorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        setTitleColor(.gray, for: .normal)
        setTitleColor(.systemBlue, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
