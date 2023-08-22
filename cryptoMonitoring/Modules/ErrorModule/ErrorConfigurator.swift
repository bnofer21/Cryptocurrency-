//
//  ErrorConfigurator.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import Combine
import UIKit

final class ErrorConfigurator {
    
    // MARK: - Methods
    
    func configure(
        with error: CustomError,
        onTryAgainSubject: PassthroughSubject<Void, Never>,
        output: ErrorViewOutput
    ) -> UIViewController {
        let viewModel = ErrorViewModel(
            error: error,
            onTryAgainSubject: onTryAgainSubject,
            output: output
        )
        let view = ErrorViewController(viewModel: viewModel)
        view.preferredSheetSizing = .fit
        
        return view
    }
}
