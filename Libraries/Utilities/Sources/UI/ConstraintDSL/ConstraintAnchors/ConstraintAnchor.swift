//
//  ConstraintAnchor.swift
//  Utilities
//
//  Created by Daniel Okada on 07/08/21.
//

import UIKit

public protocol ConstraintAnchor: Hashable {
    var asConstraintAttribute: NSLayoutConstraint.Attribute? { get }
}

public struct ConstraintAnchors {

    let item: ConstraintItem

    init(item: ConstraintItem) {
        self.item = item
    }

    public var left: ConstraintTarget<HorizontalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .left
        )
    }

    public var right: ConstraintTarget<HorizontalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .right
        )
    }

    public var leading: ConstraintTarget<HorizontalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .leading
        )
    }

    public var trailing: ConstraintTarget<HorizontalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .trailing
        )
    }

    public var centerX: ConstraintTarget<HorizontalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .centerX
        )
    }

    public var top: ConstraintTarget<VerticalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .top
        )
    }

    public var bottom: ConstraintTarget<VerticalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .bottom
        )
    }

    public var centerY: ConstraintTarget<VerticalConstraintAnchor> {
        return .init(
            item: item,
            attribute: .centerY
        )
    }

    public var width: ConstraintTarget<DimensionConstraintAnchor> {
        return .init(
            item: item,
            attribute: .width
        )
    }

    public var height: ConstraintTarget<DimensionConstraintAnchor> {
        return .init(
            item: item,
            attribute: .height
        )
    }

}

