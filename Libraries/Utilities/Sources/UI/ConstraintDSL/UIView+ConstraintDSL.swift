//
//  UIView+ConstraintDSL.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public extension UIView {

    func addSubview(_ view: UIView, @ConstraintResultBuilder makeConstraints: (BaseConstraintMaker) -> [NSLayoutConstraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let maker = BaseConstraintMaker(view: view, superview: self)
        NSLayoutConstraint.activate(makeConstraints(maker))
    }

}
