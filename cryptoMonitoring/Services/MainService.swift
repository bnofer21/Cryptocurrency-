//
//  MainService.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation

final class MainService {
    
    // MARK: - Properties
    
    lazy var cryptoService: CryptoService = DefaultCryptoService()
}
