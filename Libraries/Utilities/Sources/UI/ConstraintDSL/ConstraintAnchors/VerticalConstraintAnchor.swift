//
//  VerticalConstraintAnchor.swift
//  Utilities
//
//  Created by Daniel Okada on 11/08/21.
//

import UIKit

public enum VerticalConstraintAnchor: ConstraintAnchor {

    case top
    case bottom
    case centerY

    public var asConstraintAttribute: NSLayoutConstraint.Attribute? {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .centerY:
            return .centerY
        }
    }

}
