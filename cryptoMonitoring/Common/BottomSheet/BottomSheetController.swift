//
//  BottomSheetController.swift
//  BebsCommon
//
//  Created by Мурат Камалов on 12/19/22.
//  Copyright © 2022 OneGo. All rights reserved.
//

import UIKit

open class BottomSheetController: UIViewController {

    // MARK: - Public properties
    
    public override var additionalSafeAreaInsets: UIEdgeInsets {
        get {
            .init(
                top: super.additionalSafeAreaInsets.top + preferredSheetCornerRadius,
                left: super.additionalSafeAreaInsets.left,
                bottom: super.additionalSafeAreaInsets.bottom,
                right: super.additionalSafeAreaInsets.right
            )
        }
        set {
            super.additionalSafeAreaInsets = newValue
        }
    }

    public override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            .custom
        }
        set { }
    }

    public override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            bottomSheetTransitioningDelegate
        }
        set { }
    }

    public var preferredSheetTopInset: CGFloat = 24 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetTopInset = preferredSheetTopInset
        }
    }

    public var preferredSheetCornerRadius: CGFloat = 10 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetCornerRadius = preferredSheetCornerRadius
        }
    }

    public var preferredSheetSizing: PreferredSheetSizing = .medium {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetSizingFactor = preferredSheetSizing.rawValue
        }
    }

    public var preferredSheetBackdropColor: UIColor = .label {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetBackdropColor = preferredSheetBackdropColor
        }
    }

    public var tapToDismissEnabled: Bool = true {
        didSet {
            bottomSheetTransitioningDelegate.tapToDismissEnabled = tapToDismissEnabled
        }
    }

    public var panToDismissEnabled: Bool = true {
        didSet {
            bottomSheetTransitioningDelegate.panToDismissEnabled = panToDismissEnabled
        }
    }

    // MARK: - Private properties

    private lazy var bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate(
        preferredSheetTopInset: preferredSheetTopInset,
        preferredSheetCornerRadius: preferredSheetCornerRadius,
        preferredSheetSizingFactor: preferredSheetSizing.rawValue,
        preferredSheetBackdropColor: preferredSheetBackdropColor
    )

}
