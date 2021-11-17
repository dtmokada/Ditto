//
//  AnyConstraintAnchor.swift
//  Utilities
//
//  Created by Daniel Okada on 11/08/21.
//

import UIKit

public struct AnyConstraintAnchor: ConstraintAnchor {

    let transformIntoAttribute: () -> NSLayoutConstraint.Attribute?
    let originalAnchorHashValue: Int

    public init<Anchor: ConstraintAnchor>(_ anchor: Anchor) {
        transformIntoAttribute = {
            return anchor.asConstraintAttribute
        }
        originalAnchorHashValue = anchor.hashValue
    }

    public var asConstraintAttribute: NSLayoutConstraint.Attribute? {
        return transformIntoAttribute()
    }

    public static func == (lhs: AnyConstraintAnchor, rhs: AnyConstraintAnchor) -> Bool {
        return lhs.transformIntoAttribute() == rhs.transformIntoAttribute()
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originalAnchorHashValue)
    }

}
