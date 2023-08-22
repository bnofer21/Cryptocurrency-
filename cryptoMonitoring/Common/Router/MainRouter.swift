//
//  Coordinating.swift
//  notes
//
//  Created by Юрий on 28.02.2023.
//

import UIKit
import Photos

public class MainRouter: Router {
    private var documentInteraction: UIDocumentInteractionController?

    private let windowScene: UIWindowScene

    private var window: UIWindow?

    private var navigationController: UINavigationController? {
        if let tabBar = window?.rootViewController as? UITabBarController {
            return tabBar.selectedViewController as? UINavigationController
        }
        return window?.rootViewController as? UINavigationController
    }

    private lazy var tabBarController: UITabBarController? = {
        return self.navigationController?.viewControllers.first as? UITabBarController ?? self.navigationController?.viewControllers.first?.tabBarController
    }()

    private var topViewController: UIViewController? {
        return UIApplication.topViewController(window?.rootViewController)
    }

    /// ATENTION: IT"S ONLY FOR CREATE MOCK FLOW!!!!!!!!!!!!!
    public var MOCKtopViewController: UIViewController? {
        return topViewController
    }

    public init(windowScene: UIWindowScene) {

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.overrideUserInterfaceStyle = .light
        window?.windowScene = windowScene

        self.windowScene = windowScene
    }

    public func fullScreenPresent(_ module: Presentable?) {
        guard let viewController = module?.toPresent() else {
            return
        }
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.modalPresentationStyle = .fullScreen
        present(navViewController)
    }

    public func present(_ module: Presentable?) {
        present(module, animated: true, completion: nil)
    }

    public func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else {
            return
        }

        topViewController?.present(controller, animated: animated, completion: completion)
    }

    public func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    public func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        guard topViewController != nil else {
            setNavigationControllerRootModule(controller, animated: false, hideBar: true)
            return
        }
        topViewController?.navigationController?.pushViewController(controller, animated: animated)
    }

    public func push(_ module: Presentable?, animated: Bool, hideTabBar: Bool = false) {
        module?.toPresent()?.hidesBottomBarWhenPushed = hideTabBar
        push(module, animated: animated)
    }

    public func popModule() {
        popModule(animated: true)
    }

    public func popModule(animated: Bool) {
        if let topNavigationController = topViewController?.navigationController {
            topNavigationController.popViewController(animated: animated)
            return
        }
        navigationController?.popViewController(animated: animated)
    }

    public func popModule(animated: Bool, completion: @escaping EmptyClosure) {
        if let topNavigationController = topViewController?.navigationController {
            topNavigationController.popViewController(animated: true)
            completion()
            return
        }
        navigationController?.popViewController(animated: animated)
        completion()
    }

    public func pop(to module: Presentable?) {
        pop(to: module, animated: true)
    }

    public func pop(to module: Presentable?, animated: Bool) {
        guard let viewController = module?.toPresent() else {
            return
        }
        if #available(iOS 14.2, *) { }
        else if #available(iOS 14.0, *) {
            topViewController?.hidesBottomBarWhenPushed = false
        }
        navigationController?.popToViewController(viewController, animated: animated)
    }

    public func popToRoot() {
        popToRoot(animated: true)
    }

    public func popToRoot(animated: Bool) {
        if #available(iOS 14.2, *) { }
        else if #available(iOS 14.0, *) {
            topViewController?.hidesBottomBarWhenPushed = false
        }
        navigationController?.popToRootViewController(animated: animated)
    }

    public func dismissModule(_ module: Presentable?, animated: Bool = true, completion: (() -> Void)? = nil) {
        module?.toPresent()?.dismiss(animated: animated, completion: completion)
    }

    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    public func dismissAll() {
        dismissAll(animated: true, completion: nil)
    }
    
    public func dismissAll(animated: Bool, completion: (() -> Void)?) {
        guard tabBarController?.presentedViewController != nil else {
            completion?()
            return
        }
        tabBarController?.dismiss(animated: animated, completion: completion)
    }
    
    public func removePreviousFromNC() {
        guard var controllers = topViewController?.navigationController?.viewControllers,
              controllers.count > 1
        else {
            return
        }
        controllers.remove(at: controllers.count - 2)
        topViewController?.navigationController?.viewControllers = controllers
    }

    public func setNavigationControllerRootModule(
        _ module: Presentable?,
        animated: Bool = false,
        hideBar: Bool = false
    ) {
        if let controller = module?.toPresent() {
            navigationController?.isNavigationBarHidden = hideBar
            navigationController?.setViewControllers([controller], animated: false)
        }
    }

    public func setRootModule(_ module: Presentable?) {
        window?.rootViewController = module?.toPresent()
        window?.makeKeyAndVisible()
    }

    public func setTab(_ index: Int) {
        tabBarController?.selectedIndex = index
    }

    public func addToTabBar(_ module: Presentable) {
        guard let view = module.toPresent() else { return }
        tabBarController?.viewControllers?.append(view)
    }

    public func showSimpleAlert(text: String) {
        topViewController?.showSimpleAlert(title: text)
    }
    
}
