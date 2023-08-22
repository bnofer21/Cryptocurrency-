//
//  CryptoConfigurator.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import UIKit

final class CryptoConfigurator {
    
    // MARK: - Methods
    
    func configure(
        cryptoService: CryptoService,
        output: CryptoOutput
    ) -> UIViewController {
        let viewModel = CryptoViewModel(
            cryptoService: cryptoService,
            output: output
        )
        let view = CryptoViewController(viewModel: viewModel)
        
        return view
    }
}
