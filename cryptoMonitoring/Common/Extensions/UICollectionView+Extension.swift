//
//  UICollectionView+Extension.swift
//  notes
//
//  Created by Юрий on 11.06.2023.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(
            cellType.self,
            forCellWithReuseIdentifier: String(describing: T.self)
        )
    }

    func register<T: UICollectionReusableView>(header: T.Type, ofKind: String) {
        register(
            T.self,
            forSupplementaryViewOfKind: ofKind,
            withReuseIdentifier: String(describing: T.self)
        )
    }

    /// Get collection view cell
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as! T
    }

    func dequeue<T: UICollectionReusableView>(for indexPath: IndexPath, ofKind: String) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as! T
    }
}
