//
//  BaseCoordinator.swift
//  BebsCommon
//
//  Created by Мурат Камалов on 11/22/22.
//  Copyright © 2022 com.oneGo. All rights reserved.
//

import UIKit
import Foundation

open class BaseCoordinator: Coordinator {

    // MARK: - Properties

    public var childCoordinators: [Coordinator] = []

    public init() {}

    open func start() { }

    public func addDependency(_ coordinator: Coordinator) {
        // add only unique object
        guard !hasSameDependency(coordinator) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else {
            return
        }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    public func removeAllChilds() {
        guard
            !childCoordinators.isEmpty
        else {
            return
        }

        for coordinator in childCoordinators {
            if let coordinator = coordinator as? BaseCoordinator {
                coordinator.removeAllChilds()
            }
        }

        childCoordinators.removeAll()
    }

    public func hasDependency<T>(ofType: T.Type) -> Coordinator? {
        guard
            !childCoordinators.isEmpty
        else {
            return nil
        }

        for coordinator in childCoordinators {
            if coordinator is T {
                return coordinator
            }
        }

        return nil
    }

    // MARK: - Private methods

    private func hasSameDependency(_ coordinator: Coordinator) -> Bool {
        for element in childCoordinators {
            if element === coordinator {
                return true
            }
        }
        return false
    }

}
