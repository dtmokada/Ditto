//
//  NSLayoutConstraint+Extensions.swift
//  Utilities
//
//  Created by Daniel Okada on 11/08/21.
//

import UIKit

extension Array where Element == NSLayoutConstraint {

    public func priority(_ priority: UILayoutPriority) -> Self {
        forEach { constraint in
            constraint.priority = priority
        }
        return self
    }

    public func multiplier(_ value: CGFloat) -> Self {
        return map { constraint in
            return NSLayoutConstraint(
                item: constraint.firstItem as Any,
                attribute: constraint.firstAttribute,
                relatedBy: constraint.relation,
                toItem: constraint.secondItem,
                attribute: constraint.secondAttribute,
                multiplier: value,
                constant: constraint.constant
            )
        }
    }

    public func offset(_ value: CGFloat) -> Self {
        forEach { constraint in
            constraint.constant = value
        }
        return self
    }

    public func inset(_ value: CGFloat) -> Self {
        let negativeOffsetAttributes: [NSLayoutConstraint.Attribute] = [
            .right,
            .rightMargin,
            .trailing,
            .trailingMargin,
            .centerX,
            .centerXWithinMargins,
            .bottom,
            .bottomMargin,
            .centerY,
            .centerYWithinMargins,
            .width,
            .height,
        ]
        forEach { constraint in
            if negativeOffsetAttributes.contains(constraint.secondAttribute) {
                constraint.constant = -value
            } else {
                constraint.constant = value
            }
        }
        return self
    }

}
