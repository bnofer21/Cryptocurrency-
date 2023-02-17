//
//  CryptoInteractor.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

protocol CryptoInteractorInput {
    var output: CryptoInteractorOutput? { get set }
    func loadCrypto()
    func returnFilterArray(moneyType: Resources.SelectButtons)
    func searchCoin(searchText: String, type: Resources.SelectButtons)
}

protocol CryptoInteractorOutput: AnyObject {
    func didLoadCrypto(_ coins: [Coin])
    func didReceive(error: String)
}

final class CryptoInteractor: CryptoInteractorInput {
    
    var defaultArray = [Coin]()
    
    weak var output: CryptoInteractorOutput?
    var cryptoLoader: CryptoLoaderInterface?
    
    func loadCrypto() {
        cryptoLoader?.loadCrypto { [weak self] coins, error in
            if let error = error {
                self?.output?.didReceive(error: error)
            } else if let coins = coins {
                self?.defaultArray = coins
                self?.output?.didLoadCrypto(coins)
            }
        }
    }
    
    func returnFilterArray(moneyType: Resources.SelectButtons) {
        let filtered = filterArray(type: moneyType)
        self.output?.didLoadCrypto(filtered)
    }
    
    func searchCoin(searchText: String, type: Resources.SelectButtons) {
        var filtered = filterArray(type: type)
        filtered = filtered.filter({ $0.ticker.contains(searchText) || $0.fullName.contains(searchText)})
        self.output?.didLoadCrypto(filtered)
    }
    
    private func filterArray(type: Resources.SelectButtons) -> [Coin] {
        var filteredArray = [Coin]()
        switch type {
        case Resources.SelectButtons.all:
            filteredArray = defaultArray
        case Resources.SelectButtons.fiat:
            filteredArray = defaultArray.filter({ $0.moneyType == 0})
        default:
            filteredArray = defaultArray.filter({ $0.moneyType == 1})
        }
        return filteredArray
    }
}
