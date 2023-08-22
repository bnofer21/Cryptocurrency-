//
//  TabCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import UIKit

final class TabCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private let tablabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with text: String) {
        tablabel.text = text
    }
}

// MARK: - Private methods

private extension TabCell {
    func setup() {
        contentView.addSubview(tablabel)
        tablabel.pinToSuperView(sides: .centerXR, .centerYR)
        tablabel.font = .systemFont(ofSize: 17)
        tablabel.textColor = .black
        tablabel.textAlignment = .center
    }
}
