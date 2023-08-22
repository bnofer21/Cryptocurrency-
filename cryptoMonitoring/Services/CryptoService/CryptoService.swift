//
//  CryptoService.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Combine

protocol CryptoService {
    func loadCrypto() -> AnyPublisher<[CoinEntry], Error>
}
