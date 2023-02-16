//
//  RootWireframe.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import UIKit

class RootWireframe {
    
    class func setupWith(_ window: UIWindow) {
        let vc = CryptoViewController()
        let conf = CryptoConfigurator()
        conf.configureModuleForViewInput(viewInput: vc)
        
        let navVC = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navVC
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }
}
