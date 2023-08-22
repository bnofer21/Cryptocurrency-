//
//  CryptoCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class CryptoCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private let imageView = LoadImageView()
    private let tickerLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionView methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Methods
    
    func configue(with model: CoinUIModel) {
        imageView.loadImage(for: model.image)
        tickerLabel.text = model.ticker
        nameLabel.text = model.name
        priceLabel.isHidden = model.price.isEmpty
        priceLabel.text = "$ \(model.price)"
    }
}

// MARK: - Private proeprties

private extension CryptoCell {
    func setup() {
        contentView.addSubview(imageView)
        imageView.setEqualSize(constant: 48)
        imageView.pinToSuperView(sides: .left(16), .top(8), .bottom(-8))
        imageView.layer.cornerRadius = 24
        imageView.skeletonCornerRadius = 24
        
        let stack = UIStackView(arrangedSubviews: [tickerLabel, nameLabel])
        contentView.addSubview(stack)
        stack.pin(side: .left(8), to: .right(imageView))
        stack.pinToSuperView(sides: .centerYR)
        stack.axis = .vertical
        stack.spacing = 2
        
        tickerLabel.textColor = .black
        tickerLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .gray
        
        contentView.addSubview(priceLabel)
        priceLabel.pinToSuperView(sides: .right(-16), .centerYR)
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .systemGreen
    }
}
