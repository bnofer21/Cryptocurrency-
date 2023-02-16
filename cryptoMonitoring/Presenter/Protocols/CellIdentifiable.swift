//
//  CellIdentifiable.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Float { get }
}
