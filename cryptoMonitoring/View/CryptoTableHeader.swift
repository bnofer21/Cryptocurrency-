//
//  CryptoTableHeader.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import UIKit

final class CryptoTableHeader: UITableViewHeaderFooterView {
    
    static let id = "CryptoTableHeader"
    
    var buttons = [SelectorButton]()
    
    var spacing: CGFloat = 10
    var animatedSelector: UIView = {
        let sel = UIView()
        return sel
    }()
    
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.backgroundColor = .white
        return sv
    }()
    
    var toolbar: UIToolbar = {
        let bar = UIToolbar()
        return bar
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        createSelectButtons()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.createSelector(sender: self.buttons[0])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSelectButtons() {
        let count = 3
        for i in 0..<count {
            let button = SelectorButton()
            if i == 0 {
                button.isSelected = true
            }
            button.moneyType = Resources.SelectButtons.allCases[i]
            button.setTitle(Resources.SelectButtons.allCases[i].rawValue, for: .normal)
            button.addTarget(self, action: #selector(selectItem(sender:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupView() {
        addView(view: stackView)
        stackView.addView(view: animatedSelector)
    }
    
    private func createSelector(sender: SelectorButton) {
        animatedSelector.frame = CGRect(x: sender.frame.minX, y: sender.frame.origin.y, width: sender.frame.width, height: 4)
        animatedSelector.backgroundColor = .systemBlue
        self.addSubview(animatedSelector)
    }
    
    @objc func selectItem(sender: SelectorButton) {
        for button in buttons {
            if button.isSelected {
                button.isSelected.toggle()
            }
        }
        sender.isSelected.toggle()
        let x = sender.frame.minX
        let y = sender.frame.origin.y
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.animatedSelector.transform = CGAffineTransform(translationX: x, y: y)
        }
    }
    
}

extension CryptoTableHeader {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
