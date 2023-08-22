//
//  CryptoErrorCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 13.08.2023.
//

import Foundation
import UIKit

final class CryptoErrorCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private methods

private extension CryptoErrorCell {
    func setup() {
        contentView.addSubview(imageView)
        imageView.setEqualSize(constant: 24)
        imageView.pinToSuperView(sides: .top(16), .centerXR)
        imageView.image = UIImage(systemName: "arrow.clockwise")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        
        contentView.addSubview(label)
        label.pin(side: .top(8), to: .bottom(imageView))
        label.pinToSuperView(sides: .centerXR, .bottom(-16))
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.text = "Error loading currencies"
    }
}
