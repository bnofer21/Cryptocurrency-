//
//  ErrorType.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation

enum CustomError: Error {
    case networkLost
    case wrongUrl
    case custom(String)
    case serverError
    case noDataReceived
    case noResponse
    case badData
    
    // MARK: - Properties
    
    public var message: String {
        switch self {
        case .networkLost:
            return "Network lost, please check the internet connection"
        case .wrongUrl:
            return "Wrong url address"
        case .custom(let error):
            return error
        case .serverError:
            return "API error"
        case .noDataReceived:
            return "No data received from server"
        case .noResponse:
            return "No response from server"
        case .badData:
            return "Bad data from server"
        }
    }
    
    public var description: String {
        switch self {
        default:
            return "There are some problems with internet, try again later"
        }
    }
}
