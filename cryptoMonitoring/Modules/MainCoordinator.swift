//
//  MainCoordinator.swift
//  notes
//
//  Created by Юрий on 11.06.2023.
//
import UIKit
import Combine

class MainCoordinator: BaseCoordinator {
    
    // MARK: - Private properties
    
    private let router: MainRouter
    private let mainService = MainService()
    
    // MARK: - Init
    
    init(window: UIWindowScene) {
        router = MainRouter(windowScene: window)
        super.init()
    }
    
    // MARK: - Internal Methods
    
    override func start() {
        let view = CryptoConfigurator().configure(
            cryptoService: mainService.cryptoService,
            output: self
        )
        let navigation = UINavigationController(rootViewController: view)
        router.setRootModule(navigation)
    }
    
}

// MARK: - CryptoOutput methods

extension MainCoordinator: CryptoOutput {
    
    func show(_ error: CustomError, tryAgainSubject: PassthroughSubject<Void, Never>) {
        let view = ErrorConfigurator().configure(
            with: error,
            onTryAgainSubject: tryAgainSubject,
            output: self
        )
        router.present(view)
    }
}

// MARK: - ErrorViewOutput methods

extension MainCoordinator: ErrorViewOutput {
    
    func onCloseView() {
        router.dismissModule()
    }
    
}
