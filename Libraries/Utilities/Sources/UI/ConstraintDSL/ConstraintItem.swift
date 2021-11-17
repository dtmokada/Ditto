//
//  ConstraintItem.swift
//  Utilities
//
//  Created by Daniel Okada on 07/08/21.
//

import UIKit

public protocol ConstraintItem: AnyObject {
    var anchors: ConstraintAnchors { get }
}

extension UIView: ConstraintItem {

    public var anchors: ConstraintAnchors {
        return .init(item: self)
    }

}

extension UILayoutGuide: ConstraintItem {

    public var anchors: ConstraintAnchors {
        return .init(item: self)
    }

}
