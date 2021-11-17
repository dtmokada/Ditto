//
//  GroupConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public extension ConstraintMaker where Anchor == AnyConstraintAnchor {

    func equalTo(_ relatable: GroupConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.equal, to: relatable)
    }

    func greaterThanOrEqualTo(_ relatable: GroupConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.greaterThanOrEqual, to: relatable)
    }

    func lessThanOrEqualTo(_ relatable: GroupConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.lessThanOrEqual, to: relatable)
    }

    var center: ConstraintMaker<AnyConstraintAnchor> {
        return addingAnchors([
            AnyConstraintAnchor(HorizontalConstraintAnchor.centerX),
            AnyConstraintAnchor(VerticalConstraintAnchor.centerY),
        ])
    }

    var edges: ConstraintMaker<AnyConstraintAnchor> {
        return addingAnchors([
            AnyConstraintAnchor(HorizontalConstraintAnchor.leading),
            AnyConstraintAnchor(HorizontalConstraintAnchor.trailing),
            AnyConstraintAnchor(VerticalConstraintAnchor.top),
            AnyConstraintAnchor(VerticalConstraintAnchor.bottom),
        ])
    }

    var size: ConstraintMaker<AnyConstraintAnchor> {
        return addingAnchors([
            AnyConstraintAnchor(DimensionConstraintAnchor.width),
            AnyConstraintAnchor(DimensionConstraintAnchor.height),
        ])
    }

}
