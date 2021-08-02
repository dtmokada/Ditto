//
//  NWStubsTests.swift
//  NetworkingMockTests
//
//  Created by Daniel Okada on 02/08/21.
//

import XCTest
@testable import NetworkingMock

class NWStubsTests: XCTestCase {

    var sut: NWStubs!

    override func setUpWithError() throws {
        sut = .fixture()
    }

    func testRegisterStubCollection() throws {
        let stubCollectionType = DummyStubCollection.self
        let fileUrlPrefix = "file://"
        let dummyFilename = "dummy.json"

        sut.register(stubCollection: stubCollectionType)

        let registeredStubs = sut.stubs
        XCTAssertEqual(registeredStubs.count, 3)
        XCTAssertEqual(registeredStubs.keys.sorted(), [
            "regex-200",
            "regex-404",
            "regex-501",
        ])

        let stub200 = try XCTUnwrap(registeredStubs["regex-200"])
        XCTAssertTrue(stub200.0.absoluteString.hasPrefix(fileUrlPrefix))
        XCTAssertTrue(stub200.0.absoluteString.hasSuffix(dummyFilename))
        XCTAssertEqual(stub200.1, 200)

        let stub404 = try XCTUnwrap(registeredStubs["regex-404"])
        XCTAssertTrue(stub404.0.absoluteString.hasPrefix(fileUrlPrefix))
        XCTAssertTrue(stub404.0.absoluteString.hasSuffix(dummyFilename))
        XCTAssertEqual(stub404.1, 404)

        let stub501 = try XCTUnwrap(registeredStubs["regex-501"])
        XCTAssertTrue(stub501.0.absoluteString.hasPrefix(fileUrlPrefix))
        XCTAssertTrue(stub501.0.absoluteString.hasSuffix(dummyFilename))
        XCTAssertEqual(stub501.1, 501)
    }

    func testRegister_validFile() throws {
        let regex = "some-regex"
        let filename = "dummy.json"
        let bundle = Bundle(for: Self.self)
        let statusCode = 500

        sut.register(urlRegex: regex, file: filename, inBundle: bundle, statusCode: statusCode)

        let registeredStubs = sut.stubs
        XCTAssertEqual(registeredStubs.count, 1)
        let newStub = try XCTUnwrap(registeredStubs[regex])
        XCTAssertTrue(newStub.0.absoluteString.hasPrefix("file://"))
        XCTAssertTrue(newStub.0.absoluteString.hasSuffix(filename))
        XCTAssertEqual(newStub.1, statusCode)
    }

    func testRegister_missingFile() throws {
        let regex = "some-regex"
        let filename = "non-existent-file.json"
        let bundle = Bundle(for: Self.self)
        let statusCode = 500

        sut.register(urlRegex: regex, file: filename, inBundle: bundle, statusCode: statusCode)

        let registeredStubs = sut.stubs
        XCTAssertTrue(registeredStubs.isEmpty)
    }

    func testRemoveStubForUrlRegex() throws {
        sut = .fixture(stubs: [
            "keep": (URL(string: "https://apple.com")!, 200),
            "remove": (URL(string: "https://google.com")!, 404),
        ])

        sut.removeStubFor(urlRegex: "remove")

        let remainingStubs = sut.stubs
        XCTAssertEqual(remainingStubs.count, 1)
        let keptStub = try XCTUnwrap(remainingStubs["keep"])
        XCTAssertEqual(keptStub.0.absoluteString, "https://apple.com")
        XCTAssertEqual(keptStub.1, 200)
    }

    func testRemoveAllStubs() {
        sut = .fixture(stubs: [
            "remove": (URL(string: "https://apple.com")!, 200),
            "remove-too": (URL(string: "https://google.com")!, 404),
        ])

        sut.removeAllStubs()

        let remainingStubs = sut.stubs
        XCTAssertTrue(remainingStubs.isEmpty)
    }

    func testDataForRequest() throws {
        let regex = "https://\\w+.com"
        let urlString = "https://apple.com"
        let file = "dummy.json"
        let path = try XCTUnwrap(Bundle(for: Self.self).path(forResource: file, ofType: nil))
        let fileUrl = URL(fileURLWithPath: path)
        let requestUrl = try XCTUnwrap(URL(string: urlString))
        let request = URLRequest(url: requestUrl)
        sut = .fixture(stubs: [
            regex: (fileUrl, 123)
        ])

        let (data, statusCode) = try XCTUnwrap(sut.dataFor(request: request))
        XCTAssertEqual(statusCode, 123)
        let string = String(data: data, encoding: .utf8)
        XCTAssertEqual(string, "{ }")
    }

    func testDataForRequest_nonMatchingRegex() throws {
        let regex = "something that doesn't match"
        let urlString = "https://apple.com"
        let file = "dummy.json"
        let path = try XCTUnwrap(Bundle(for: Self.self).path(forResource: file, ofType: nil))
        let fileUrl = URL(fileURLWithPath: path)
        let requestUrl = try XCTUnwrap(URL(string: urlString))
        let request = URLRequest(url: requestUrl)
        sut = .fixture(stubs: [
            regex: (fileUrl, 123)
        ])

        let data = sut.dataFor(request: request)
        XCTAssertNil(data)
    }

}

fileprivate class DummyStubCollection: NWStubCollection {

    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }

    static var stubs: [NWStub] {
        [
            .init(urlRegex: "regex-200", file: "dummy.json", statusCode: 200),
            .init(urlRegex: "regex-404", file: "dummy.json", statusCode: 404),
            .init(urlRegex: "regex-non-existent-file", file: "non-existent.json", statusCode: 404),
            .init(urlRegex: "regex-501", file: "dummy.json", statusCode: 501),
        ]
    }

}
