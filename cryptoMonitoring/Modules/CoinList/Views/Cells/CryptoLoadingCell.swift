//
//  CryptoLoadingCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import UIKit
import SkeletonView

final class CryptoLoadingCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private let imageView = UIView()
    private let label = UIView()
    private let subLabel = UIView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        showAnimatedGradientSkeleton()
    }
    
}

// MARK: - Private methods

private extension CryptoLoadingCell {
    func setup() {
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        contentView.addSubview(imageView)
        imageView.setEqualSize(constant: 48)
        imageView.pinToSuperView(sides: .left(16), .top(8), .bottom(-8))
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 24
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        contentView.addSubview(stack)
        stack.pin(side: .left(8), to: .right(imageView))
        stack.pinToSuperView(sides: .centerYR)
        stack.axis = .vertical
        stack.spacing = 2
        stack.isSkeletonable = true
        
        label.isSkeletonable = true
        label.setDemission(.width(100))
        label.setDemission(.height(18))
        label.skeletonCornerRadius = 6
        
        subLabel.isSkeletonable = true
        subLabel.setDemission(.width(150))
        subLabel.setDemission(.height(15))
        subLabel.skeletonCornerRadius = 6
    }
}
