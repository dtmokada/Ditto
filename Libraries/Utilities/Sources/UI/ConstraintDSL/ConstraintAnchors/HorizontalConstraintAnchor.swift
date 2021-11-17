//
//  HorizontalConstraintAnchor.swift
//  Utilities
//
//  Created by Daniel Okada on 11/08/21.
//

import UIKit

public enum HorizontalConstraintAnchor: ConstraintAnchor {

    case left
    case right
    case leading
    case trailing
    case centerX

    public var asConstraintAttribute: NSLayoutConstraint.Attribute? {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .centerX:
            return .centerX
        }
    }

}
