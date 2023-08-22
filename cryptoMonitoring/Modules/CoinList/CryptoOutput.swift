//
//  CryptoOutput.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import Combine

protocol CryptoOutput {
    func show(_ error: CustomError, tryAgainSubject: PassthroughSubject<Void, Never>)
}
