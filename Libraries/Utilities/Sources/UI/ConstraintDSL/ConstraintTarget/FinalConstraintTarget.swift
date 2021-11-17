//
//  FinalConstraintTarget.swift
//  Utilities
//
//  Created by Daniel Okada on 07/08/21.
//

import UIKit

public struct FinalConstraintTarget {

    public let item: ConstraintItem
    public let attribute: NSLayoutConstraint.Attribute?

    init(item: ConstraintItem, attribute: NSLayoutConstraint.Attribute?) {
        self.item = item
        self.attribute = attribute
    }

    public var asConstraintTarget: FinalConstraintTarget {
        return self
    }

}
