//
//  HorizontalConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public extension ConstraintMaker where Anchor == HorizontalConstraintAnchor {

    func equalTo(_ relatable: HorizontalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.equal, to: relatable)
    }

    func greaterThanOrEqualTo(_ relatable: HorizontalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.greaterThanOrEqual, to: relatable)
    }

    func lessThanOrEqualTo(_ relatable: HorizontalConstraintRelatable) -> [NSLayoutConstraint] {
        return constrain(.lessThanOrEqual, to: relatable)
    }

    var left: ConstraintMaker<HorizontalConstraintAnchor> {
        return addingAnchor(.left)
    }

    var right: ConstraintMaker<HorizontalConstraintAnchor> {
        return addingAnchor(.right)
    }

    var leading: ConstraintMaker<HorizontalConstraintAnchor> {
        return addingAnchor(.leading)
    }

    var trailing: ConstraintMaker<HorizontalConstraintAnchor> {
        return addingAnchor(.trailing)
    }

    var centerX: ConstraintMaker<HorizontalConstraintAnchor> {
        return addingAnchor(.centerX)
    }

}
