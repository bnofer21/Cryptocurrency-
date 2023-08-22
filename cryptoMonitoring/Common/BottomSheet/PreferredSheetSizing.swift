//
//  PreferredSheetSizing.swift
//  BebsCommon
//
//  Created by Мурат Камалов on 12/19/22.
//  Copyright © 2022 OneGo. All rights reserved.
//

import Foundation

public enum PreferredSheetSizing: CGFloat {
    case none = -1
    case fit = 0 /// Fit, based on the view's constraints
    case small = 0.25 /// Fix 0.25 of screen
    case medium = 0.5 /// Fix 0.5 of screen
    case big = 0.6 /// Fix 0.6 of screen
    case large = 0.75 /// Fix 0.75 of screen
    case fill = 1 /// Fix 1.0 of screen
}
