//
//  SelectorButton.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import UIKit

class SelectorButton: UIButton {
    
//    override var isSelected: Bool {
//        didSet {
//            isSelected ? setTitleColor(.systemBlue, for: .normal) : setTitleColor(.gray, for: .normal)
//        }
//    }
    
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
