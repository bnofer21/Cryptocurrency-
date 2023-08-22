//
//  UIControl+Combine.swift
//  BebsCommon
//
//  Created by Роман Шуркин on 10.12.2022.
//  Copyright © 2022 OneGo. All rights reserved.
//

import Combine
import UIKit

/// A custom `UIControlSubscription`.
public final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription
    where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(
        subscriber: SubscriberType,
        control: Control,
        event: UIControl.Event
    ) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    public func request(_: Subscribers.Demand) {}

    public func cancel() {
        subscriber = nil
    }

    @objc
    private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
public struct UIControlPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    init(
        control: Control,
        events: UIControl.Event
    ) {
        self.control = control
        self.controlEvents = events
    }

    public func receive<S>(subscriber: S)
        where S: Subscriber,
        S.Failure == UIControlPublisher.Failure,
        S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
public protocol CombineCompatible {}

extension UIControl: CombineCompatible {}

public extension CombineCompatible
    where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        UIControlPublisher(control: self, events: events)
    }
}
