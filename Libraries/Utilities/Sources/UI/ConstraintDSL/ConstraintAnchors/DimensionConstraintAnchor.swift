//
//  DimensionConstraintAnchor.swift
//  Utilities
//
//  Created by Daniel Okada on 11/08/21.
//

import UIKit

public enum DimensionConstraintAnchor: ConstraintAnchor {

    case width
    case height

    public var asConstraintAttribute: NSLayoutConstraint.Attribute? {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        }
    }

}
