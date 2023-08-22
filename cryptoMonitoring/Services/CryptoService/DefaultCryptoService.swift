//
//  JSONDecode.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation
import Combine

final class DefaultCryptoService: CryptoService {
    
    // MARK: - Methods
    
    func loadCrypto() -> AnyPublisher<[CoinEntry], Error> {
        guard let url = URL(string: "https://rest.coinapi.io/v1/assets?apikey=DE69ED22-17F3-46ED-83E2-8196394EBCFA")
        else { return Fail(error: CustomError.wrongUrl).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError{ error in
                switch error.code {
                case .networkConnectionLost, .notConnectedToInternet:
                    return CustomError.networkLost
                case .badURL, .unsupportedURL, .cannotFindHost:
                    return CustomError.wrongUrl
                case .timedOut:
                    return CustomError.serverError
                case .badServerResponse, .cannotParseResponse:
                    return CustomError.badData
                default:
                    return CustomError.custom("Unknown error")
                }
            }
            .map{ $0.data }
            .decode(type: [CoinEntry].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}




