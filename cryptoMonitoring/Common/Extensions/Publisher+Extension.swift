//
//  Publisher+Extension.swift
//  BebsCommon
//
//  Created by Роман Шуркин on 18.01.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Combine

public extension Publisher {
    
    /// For use subscriptions with weak links
    /// - Parameter obj: subsriptions
    /// - Returns: Return subscriptions
    func withUnretained<Unretained: AnyObject>(
        _ obj: Unretained
    ) -> AnyPublisher<(obj: Unretained, value: Self.Output), Failure> {
        compactMap { [weak obj] value -> (obj: Unretained, value: Self.Output)? in
            guard let obj = obj else {
                return nil
            }
            return (obj: obj, value: value)
        }
        .eraseToAnyPublisher()
    }
    
    /// Use for subscribe with weak links
    /// - Parameter subject: Subscriptions
    /// - Returns: Return Subsribe of subscriptions
    func weakSubscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output {
        return sink { [weak subject] error in
            subject?.send(completion: error)
        } receiveValue: { [weak subject] output in
            subject?.send(output)
        }
    }
}
