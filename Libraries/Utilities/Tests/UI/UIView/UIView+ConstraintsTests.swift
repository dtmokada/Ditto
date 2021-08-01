//
//  UIView+ConstraintsTests.swift
//  UtilitiesTests
//
//  Created by Daniel Okada on 20/06/21.
//

import XCTest
@testable import Utilities

class UIViewConstraintsTests: XCTestCase {

    func testAddSubviewWithConstraints() {
        let view = UIView()
        let childView = UIView()
        let constraints = [
            childView.topAnchor.constraint(equalTo: view.topAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]

        view.addSubview(view: childView, constraints: constraints)

        XCTAssertEqual(childView.superview, view)
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(view.constraints, constraints)
        print(constraints)
    }

}
