//
//  CryptoBaseInfoCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import UIKit

class CryptoBaseInfoCell: CryptoBaseCell {
    
    var icon: CustomIV = {
        let icon = CustomIV()
        icon.backgroundColor = .lightGray
        icon.contentMode = .scaleToFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 20
        return icon
    }()
    
    var fullNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var tickerLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addView(view: icon)
        addView(view: fullNameLabel)
        addView(view: tickerLabel)
        addView(view: priceLabel)
    }
    
    override func updateViews() {
        guard let model = model as? CryptoBaseInfoCellModel else { return }
        if let price = model.price {
            priceLabel.text = "\(price)"
        }
        if let id = model.idIcon {
            icon.loadImage(idIcon: id)
        }
        fullNameLabel.text = model.fullName
        tickerLabel.text = model.ticker
    }

}

extension CryptoBaseInfoCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40),
            
            fullNameLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: -7),
            fullNameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            
            tickerLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 7),
            tickerLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            
            priceLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
