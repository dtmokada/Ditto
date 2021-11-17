//
//  ConstraintResultBuilder.swift
//  Utilities
//
//  Created by Daniel Okada on 07/08/21.
//

import UIKit

@resultBuilder
public struct ConstraintResultBuilder {

    public static func buildBlock() -> [NSLayoutConstraint] {
        return []
    }

    public static func buildBlock(_ components: ConstraintsConvertible...) -> [NSLayoutConstraint] {
        return components.flatMap { $0.asConstraints }
    }

    public static func buildBlock(_ components: [ConstraintsConvertible]...) -> [NSLayoutConstraint] {
        return components.flatMap { $0.flatMap { $0.asConstraints } }
    }

    public static func buildArray(_ components: [[ConstraintsConvertible]]) -> [NSLayoutConstraint] {
        return components.flatMap { $0.flatMap { $0.asConstraints } }
    }

    public static func buildEither(first component: [ConstraintsConvertible]) -> [ConstraintsConvertible] {
        return component
    }

    public static func buildEither(second component: [ConstraintsConvertible]) -> [ConstraintsConvertible] {
        return component
    }

    public static func buildOptional(_ component: [ConstraintsConvertible]?) -> [ConstraintsConvertible] {
        return component ?? []
    }

}
