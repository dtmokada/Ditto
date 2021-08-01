//
//  UIView+Constraints.swift
//  Utilities
//
//  Created by Daniel Okada on 08/07/21.
//

import UIKit

public extension UIView {

    func addSubview(view: UIView, constraints: @autoclosure () -> [NSLayoutConstraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints())
    }

}
