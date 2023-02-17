//
//  CryptoPresenter.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

protocol CryptoPresenterInput {
    
}

final class CryptoPresenter: CryptoPresenterInput, CryptoViewOutput, CryptoInteractorOutput {
    
    weak var view: CryptoViewInput?
    var interactor: CryptoInteractorInput?
//  (not used)  var router: CryptoRouterInput?
    
    func viewDidLoad() {
        print("request")
        interactor?.loadCrypto()
    }
    
    func didLoadCrypto(_ coins: [Coin]) {
        let section = CryptoSectionModel(coins)
        view?.updateForSection(section)
    }
    
    func didReceive(error: String) {
        print(error)
    }
    
    func filterChanged(showType: Resources.SelectButtons) {
        interactor?.returnFilterArray(moneyType: showType)
    }
    
    func searchCoin(searchText: String, moneyType: Resources.SelectButtons) {
        interactor?.searchCoin(searchText: searchText, type: moneyType)
    }
}

