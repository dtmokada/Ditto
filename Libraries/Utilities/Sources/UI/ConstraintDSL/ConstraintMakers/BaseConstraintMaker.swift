//
//  BaseConstraintMaker.swift
//  Utilities
//
//  Created by Daniel Okada on 07/08/21.
//

import UIKit

public class BaseConstraintMaker {

    let view: UIView
    let superview: UIView

    init(view: UIView, superview: UIView) {
        self.view = view
        self.superview = superview
    }

    func makerWith<Anchor>(anchor: Anchor) -> ConstraintMaker<Anchor> {
        makerWith(anchors: [anchor])
    }

    func makerWith<Anchor>(anchors: Set<Anchor>) -> ConstraintMaker<Anchor> {
        return .init(view: view, superview: superview, anchors: anchors)
    }

}

public extension BaseConstraintMaker {

    var left: ConstraintMaker<HorizontalConstraintAnchor> {
        return makerWith(anchor: .left)
    }

    var right: ConstraintMaker<HorizontalConstraintAnchor> {
        return makerWith(anchor: .right)
    }

    var leading: ConstraintMaker<HorizontalConstraintAnchor> {
        return makerWith(anchor: .leading)
    }

    var trailing: ConstraintMaker<HorizontalConstraintAnchor> {
        return makerWith(anchor: .trailing)
    }

    var centerX: ConstraintMaker<HorizontalConstraintAnchor> {
        return makerWith(anchor: .centerX)
    }

    var top: ConstraintMaker<VerticalConstraintAnchor> {
        return makerWith(anchor: .top)
    }

    var bottom: ConstraintMaker<VerticalConstraintAnchor> {
        return makerWith(anchor: .bottom)
    }

    var centerY: ConstraintMaker<VerticalConstraintAnchor> {
        return makerWith(anchor: .centerY)
    }

    var width: ConstraintMaker<DimensionConstraintAnchor> {
        return makerWith(anchor: .width)
    }

    var height: ConstraintMaker<DimensionConstraintAnchor> {
        return makerWith(anchor: .height)
    }

    var center: ConstraintMaker<AnyConstraintAnchor> {
        return makerWith(anchors: [
            AnyConstraintAnchor(HorizontalConstraintAnchor.centerX),
            AnyConstraintAnchor(VerticalConstraintAnchor.centerY),
        ])
    }

    var edges: ConstraintMaker<AnyConstraintAnchor> {
        return makerWith(anchors: [
            AnyConstraintAnchor(HorizontalConstraintAnchor.leading),
            AnyConstraintAnchor(HorizontalConstraintAnchor.trailing),
            AnyConstraintAnchor(VerticalConstraintAnchor.top),
            AnyConstraintAnchor(VerticalConstraintAnchor.bottom),
        ])
    }

    var size: ConstraintMaker<AnyConstraintAnchor> {
        return makerWith(anchors: [
            AnyConstraintAnchor(DimensionConstraintAnchor.width),
            AnyConstraintAnchor(DimensionConstraintAnchor.height),
        ])
    }

}
