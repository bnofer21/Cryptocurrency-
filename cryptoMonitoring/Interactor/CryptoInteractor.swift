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
}

protocol CryptoInteractorOutput: AnyObject {
    func didLoadCrypto(_ coins: [Coin])
    func didReceive(error: String)
}

final class CryptoInteractor: CryptoInteractorInput {
    
    weak var output: CryptoInteractorOutput?
    var cryptoLoader: CryptoLoaderInterface?
    
    func loadCrypto() {
        cryptoLoader?.loadCrypto { [weak self] coins, error in
            if let error = error {
                self?.output?.didReceive(error: error)
            } else if let coins = coins {
                self?.output?.didLoadCrypto(coins)
            }
        }
    }
}
