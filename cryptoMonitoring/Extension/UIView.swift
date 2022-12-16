//
//  UIView.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//

import UIKit

extension UIView {
    
    public func addView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
}
