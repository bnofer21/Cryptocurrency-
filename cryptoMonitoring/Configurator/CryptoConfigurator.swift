//
//  CryptoConfigurator.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import UIKit

final class CryptoConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let vc = viewInput as? CryptoViewController {
            configure(viewController: vc)
        }
    }
    
    private func configure(viewController: CryptoViewController) {
        
//        let router = CryptoRouter()
        
        let presenter = CryptoPresenter()
        presenter.view = viewController
//        presenter.router = router
        
        let interactor = CryptoInteractor()
        interactor.output = presenter
        interactor.cryptoLoader = CryptoLoaderService()
        
        presenter.interactor = interactor
        viewController.output = presenter
        print(viewController.output == nil)
    }
}
