//
//  ConstraintTarget.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public struct ConstraintTarget<Anchor: ConstraintAnchor>: ConstraintRelatable {

    public let item: ConstraintItem
    public let attribute: Anchor

    init(item: ConstraintItem, attribute: Anchor) {
        self.item = item
        self.attribute = attribute
    }

    public var asConstraintTarget: FinalConstraintTarget {
        return .init(
            item: item,
            attribute: attribute.asConstraintAttribute
        )
    }

}

extension ConstraintTarget: HorizontalConstraintRelatable where Anchor == HorizontalConstraintAnchor { }
extension ConstraintTarget: VerticalConstraintRelatable where Anchor == VerticalConstraintAnchor { }
extension ConstraintTarget: DimensionConstraintRelatable where Anchor == DimensionConstraintAnchor { }
