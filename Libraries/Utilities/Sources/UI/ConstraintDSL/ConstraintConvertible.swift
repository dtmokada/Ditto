//
//  ConstraintConvertible.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public protocol ConstraintsConvertible {
    var asConstraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: ConstraintsConvertible {

    public var asConstraints: [NSLayoutConstraint] {
        return [self]
    }

}

extension Array: ConstraintsConvertible where Element: ConstraintsConvertible {

    public var asConstraints: [NSLayoutConstraint] {
        return flatMap { $0.asConstraints }
    }

}
