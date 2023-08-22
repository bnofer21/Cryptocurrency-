//
//  Presentable.swift
//  Bebs
//
//  Created by Мурат Камалов on 11/22/22.
//  Copyright © 2022 OneGo. All rights reserved.
//

import UIKit

/// Describes object that can be presented in view hierarchy
public protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    public func toPresent() -> UIViewController? {
        return self
    }

}

extension UIViewController: UIDocumentInteractionControllerDelegate {

    // swiftlint:disable:next line_length
    open func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        self
    }

}
