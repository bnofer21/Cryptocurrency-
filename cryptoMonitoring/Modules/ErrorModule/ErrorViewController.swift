//
//  ErrorViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import Combine
import UIKit

final class ErrorViewController: BottomSheetController {
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    private let subtitle = UILabel()
    private let button = UIButton()
    
    private let viewModel: ErrorViewModel
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController methods
    
    override func loadView() {
        super.loadView()
        setup()
    }
}

// MARK: - Private methods

private extension ErrorViewController {
    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .top(32), .left(16), .right(-16))
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.text = viewModel.error.message
        
        view.addSubview(subtitle)
        subtitle.pin(side: .top(8), to: .bottom(titleLabel))
        subtitle.pinToSuperView(sides: .left(16), .right(-16))
        subtitle.numberOfLines = 0
        subtitle.textColor = .gray
        subtitle.font = .systemFont(ofSize: 16)
        subtitle.textAlignment = .center
        subtitle.text = viewModel.error.description
        
        view.addSubview(button)
        button.pin(side: .top(16), to: .bottom(subtitle))
        button.pinToSafeArea(side: .bottom(-8), to: .bottom(view))
        button.pinToSuperView(sides: .left(16), .right(-16))
        button.setDemission(.height(64))
        button.layer.cornerRadius = 16
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
    }
    
    func bind() {
        button.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.onTryAgain()
            }
            .store(in: &cancellableSet)
    }
}
