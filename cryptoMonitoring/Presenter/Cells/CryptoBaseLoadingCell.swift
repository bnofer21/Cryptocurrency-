//
//  CryptoBaseLoadingCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 18.02.2023.
//

import UIKit

class CryptoBaseLoadingCell: CryptoBaseCell {
    
    var activityIndicator = UIActivityIndicatorView()
    private var reloadLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to reload"
        label.textColor = .gray
        label.textAlignment = .center
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
        addSubview(activityIndicator)
        addSubview(reloadLabel)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        reloadLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
    }
    
    override func updateViews() {
        guard let model = model as? CryptoBaseLoadingCellModel else { return }
        if model.isLoading {
            activityIndicator.startAnimating()
            reloadLabel.isHidden = true
        } else {
            activityIndicator.isHidden = true
            reloadLabel.isHidden = false
        }
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            reloadLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
