//
//  UIImageView+DownloadImageTests.swift
//  UtilitiesTests
//
//  Created by Daniel Okada on 02/08/21.
//

import XCTest
import NetworkingMock
@testable import Utilities

class UIImageViewDownloadImageTests: XCTestCase {

    var sut: UIImageView!

    override func setUpWithError() throws {
        sut = UIImageView()
        UIImageView.networkingSession = NWSessionMock()
    }

    func testSetImage() throws {
        let exp = expectation(description: #function)

        let bundle = Bundle(for: Self.self)
        let imageName = "ditto.png"
        NWStubs.shared.register(urlRegex: "https://apple.com", file: imageName, inBundle: bundle, statusCode: 200)
        let url = try XCTUnwrap(URL(string: "https://apple.com"))

        sut.setImage(url: url, placeholder: nil) {
            exp.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)

        XCTAssertNotNil(sut.image)
    }

    func testSetImage_placeholderOnly() {
        let invalidUrl = URL(fileURLWithPath: "file://non-existing-image.png")
        let placeholder = UIImage(named: "ditto.png", in: Bundle(for: Self.self), compatibleWith: nil)

        sut.setImage(url: invalidUrl, placeholder: placeholder)

        XCTAssertEqual(sut.image, placeholder)
    }

}
