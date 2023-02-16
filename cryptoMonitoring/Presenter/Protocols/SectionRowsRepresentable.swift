//
//  SectionRowsRepresentable.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import Foundation

protocol SectionRowsRepresentable {
    var rows: [CellIdentifiable] { get set }
}
