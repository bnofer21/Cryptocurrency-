//
//  ErrorViewModel.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import Foundation
import Combine

final class ErrorViewModel {
    
    // MARK: - Properties
    
    let error: CustomError
    
    // MARK: - Private properties
    
    private let onTryAgainSubject: PassthroughSubject<Void, Never>
    
    private let output: ErrorViewOutput
    
    // MARK: - Init
    
    init(
        error: CustomError,
        onTryAgainSubject: PassthroughSubject<Void, Never>,
        output: ErrorViewOutput
    ) {
        self.error = error
        self.onTryAgainSubject = onTryAgainSubject
        self.output = output
    }
    
    // MARK: - Methods
    
    func onTryAgain() {
        onTryAgainSubject.send()
        output.onCloseView()
    }
}
