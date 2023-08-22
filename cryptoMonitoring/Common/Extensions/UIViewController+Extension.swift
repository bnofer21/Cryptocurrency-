//
//  UIViewController+Extension.swift
//  cryptoMonitoring
//
//  Created by Юрий on 12.08.2023.
//

import UIKit

public extension UIViewController {
    
    func showSimpleAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}
