//
//  ConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public class ConstraintMaker<Anchor: ConstraintAnchor> {

    let view: UIView
    let superview: UIView
    let anchors: Set<Anchor>

    required init(view: UIView, superview: UIView, anchors: Set<Anchor>) {
        self.view = view
        self.superview = superview
        self.anchors = anchors
    }

    func constrain(
        _ relation: NSLayoutConstraint.Relation,
        to relatable: ConstraintRelatable
    ) -> [NSLayoutConstraint] {
        let attributes = anchors.compactMap { $0.asConstraintAttribute }
        return attributes.map { attribute in
            let target = relatable.asConstraintTarget
            return NSLayoutConstraint(
                item: view,
                attribute: attribute,
                relatedBy: relation,
                toItem: target.item,
                attribute: target.attribute ?? attribute,
                multiplier: 1,
                constant: 0
            )
        }
    }

    func addingAnchor(_ anchor: Anchor) -> Self {
        var anchors = self.anchors
        anchors.insert(anchor)
        return .init(view: view, superview: superview, anchors: anchors)
    }

    func addingAnchors(_ anchors: Set<Anchor>) -> Self {
        var newAnchors = self.anchors
        anchors.forEach { newAnchors.insert($0) }
        return .init(view: view, superview: superview, anchors: newAnchors)
    }

}

public extension ConstraintMaker {

    func equalToSuperview() -> [NSLayoutConstraint] {
        return constrain(.equal, to: superview)
    }

    func greaterThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        return constrain(.greaterThanOrEqual, to: superview)
    }

    func lessThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        return constrain(.lessThanOrEqual, to: superview)
    }

    func equalToSuperviewSafeArea() -> [NSLayoutConstraint] {
        return constrain(.equal, to: superview.safeAreaLayoutGuide)
    }

}
