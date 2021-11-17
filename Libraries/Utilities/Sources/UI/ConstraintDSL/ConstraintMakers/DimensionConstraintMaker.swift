//
//  DimensionConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public extension ConstraintMaker where Anchor == DimensionConstraintAnchor {

    func equalTo(_ relatable: DimensionConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.equal, to: relatable)
    }

    func greaterThanOrEqualTo(_ relatable: DimensionConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.greaterThanOrEqual, to: relatable)
    }

    func lessThanOrEqualTo(_ relatable: DimensionConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.lessThanOrEqual, to: relatable)
    }

    var width: ConstraintMaker<DimensionConstraintAnchor> {
        return addingAnchor(.width)
    }

    var height: ConstraintMaker<DimensionConstraintAnchor> {
        return addingAnchor(.height)
    }

}
