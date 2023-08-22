//
//  CryptoMoreCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 13.08.2023.
//

import Foundation
import UIKit

final class CryptoMoreCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private let indicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Meethods
    
    func startLoading() {
        indicatorView.startAnimating()
    }
}

// MARK: - Private methods

private extension CryptoMoreCell {
    func setup() {
        contentView.addSubview(indicatorView)
        indicatorView.setEqualSize(constant: 25)
        indicatorView.pinToSuperView(sides: .centerXR, .centerYR)
    }
}
