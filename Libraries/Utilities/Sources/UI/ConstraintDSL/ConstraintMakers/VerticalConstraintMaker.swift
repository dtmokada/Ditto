//
//  VerticalConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public extension ConstraintMaker where Anchor == VerticalConstraintAnchor {

    func equalTo(_ relatable: VerticalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.equal, to: relatable)
    }

    func greaterThanOrEqualTo(_ relatable: VerticalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.greaterThanOrEqual, to: relatable)
    }

    func lessThanOrEqualTo(_ relatable: VerticalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.lessThanOrEqual, to: relatable)
    }

    var top: ConstraintMaker<VerticalConstraintAnchor> {
        return addingAnchor(.top)
    }

    var bottom: ConstraintMaker<VerticalConstraintAnchor> {
        return addingAnchor(.bottom)
    }

    var centerY: ConstraintMaker<VerticalConstraintAnchor> {
        return addingAnchor(.centerY)
    }

}
