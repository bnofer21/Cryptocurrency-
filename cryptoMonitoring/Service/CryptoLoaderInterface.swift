//
//  CryptoLoaderInterface.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

protocol CryptoLoaderInterface {
    func loadCrypto(completion: @escaping ([Coin]?, String?) -> Void)
}
