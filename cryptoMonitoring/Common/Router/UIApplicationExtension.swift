//
//  UIApplicationExtension.swift
//  Bebs
//
//  Created by Мурат Камалов on 11/22/22.
//  Copyright © 2022 OneGo. All rights reserved.
//

import UIKit

public extension UIApplication {

    class func topViewController(
        _ controller: UIViewController?) -> UIViewController? {

        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }

        return controller
    }

}
