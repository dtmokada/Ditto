//
//  ConstraintRelatable.swift
//  Utilities
//
//  Created by Daniel Okada on 08/08/21.
//

import UIKit

public protocol ConstraintRelatable {
    var asConstraintTarget: FinalConstraintTarget { get }
}

public protocol HorizontalConstraintRelatable: ConstraintRelatable { }
public protocol VerticalConstraintRelatable: ConstraintRelatable { }
public protocol DimensionConstraintRelatable: ConstraintRelatable { }

public protocol GroupConstraintRelatable: HorizontalConstraintRelatable, VerticalConstraintRelatable, DimensionConstraintRelatable { }

extension GroupConstraintRelatable where Self: ConstraintItem {

    public var asConstraintTarget: FinalConstraintTarget {
        return .init(
            item: self,
            attribute: nil
        )
    }

}

extension UIView: GroupConstraintRelatable { }
extension UILayoutGuide: GroupConstraintRelatable { }

