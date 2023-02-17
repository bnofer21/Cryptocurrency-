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
    func filterArray(moneyType: Resources.SelectButtons)
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
    
    func filterArray(moneyType: Resources.SelectButtons) {
        var filteredArray = [Coin]()
        switch moneyType {
        case Resources.SelectButtons.all:
            filteredArray = defaultArray
        case Resources.SelectButtons.fiat:
            filteredArray = defaultArray.filter({ $0.moneyType == 0})
        default:
            filteredArray = defaultArray.filter({ $0.moneyType == 1})
        }
        self.output?.didLoadCrypto(filteredArray)
    }
}
