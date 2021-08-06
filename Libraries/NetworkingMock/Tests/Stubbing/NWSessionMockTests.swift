//
//  NWSessionMockTests.swift
//  NetworkingMockTests
//
//  Created by Daniel Okada on 04/08/21.
//

import XCTest
@testable import NetworkingMock

class NWSessionMockTests: XCTestCase {

    var sut: NWSessionMock!

    override func setUpWithError() throws {
        sut = NWSessionMock()
    }

    override func tearDownWithError() throws {
        NWStubs.shared.responseDelay = nil
        NWStubs.shared.removeAllStubs()
    }

    func testDataTaskWithRequest_successWithoutDelay() {
        var dataTaskCompleted = false
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let statusCode = Int.random(in: 200...300)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.dataTask(with: request) { data, response, error in
            dataTaskCompleted = true
            XCTAssertNil(error)

            guard let httpResponse = response as? HTTPURLResponse else {
                XCTFail("Expected response to be casted to HTTPURLResponse and not to be nil")
                return
            }
            XCTAssertEqual(httpResponse.url, url)
            XCTAssertEqual(httpResponse.statusCode, statusCode)

            guard let data = data else {
                XCTFail("Expected data not to be nil")
                return
            }
            let string = String(data: data, encoding: .utf8)
            XCTAssertEqual(string, "{ }")
        }

        XCTAssertTrue(dataTaskCompleted)
    }

    func testDataTaskWithRequest_errorWithoutDelay() {
        var dataTaskCompleted = false
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)

        _ = sut.dataTask(with: request) { data, response, error in
            dataTaskCompleted = true

            XCTAssertNotNil(error)
            XCTAssertNil(response)
            XCTAssertNil(data)
        }

        XCTAssertTrue(dataTaskCompleted)
    }

    func testDataTaskWithRequest_successWithDelay() {
        var dataTaskCompleted = false
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let statusCode = Int.random(in: 200...300)
        NWStubs.shared.responseDelay = 0.05
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.dataTask(with: request) { data, response, error in
            dataTaskCompleted = true
            XCTAssertNil(error)

            guard let httpResponse = response as? HTTPURLResponse else {
                XCTFail("Expected response to be casted to HTTPURLResponse and not to be nil")
                return
            }
            XCTAssertEqual(httpResponse.url, url)
            XCTAssertEqual(httpResponse.statusCode, statusCode)

            guard let data = data else {
                XCTFail("Expected data not to be nil")
                return
            }
            let string = String(data: data, encoding: .utf8)
            XCTAssertEqual(string, "{ }")

            exp.fulfill()
        }

        XCTAssertFalse(dataTaskCompleted)
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(dataTaskCompleted)
    }

    func testDataTaskWithRequest_errorWithDelay() {
        var dataTaskCompleted = false
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        NWStubs.shared.responseDelay = 0.05

        _ = sut.dataTask(with: request) { data, response, error in
            dataTaskCompleted = true

            XCTAssertNotNil(error)
            XCTAssertNil(response)
            XCTAssertNil(data)

            exp.fulfill()
        }

        XCTAssertFalse(dataTaskCompleted)
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(dataTaskCompleted)
    }

    func testDataTaskWithRequest_cancelled() {
        var dataTaskCompleted = false
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let statusCode = Int.random(in: 200...300)
        NWStubs.shared.responseDelay = 0.01
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        let cancellable = sut.dataTask(with: request) { data, response, error in
            dataTaskCompleted = true

            let nsError = error as NSError?
            XCTAssertEqual(nsError?.code, -999)
            XCTAssertNil(response)
            XCTAssertNil(data)

            exp.fulfill()
        }

        cancellable.cancel()
        XCTAssertFalse(dataTaskCompleted)
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(dataTaskCompleted)
    }

    func testDataTaskWithUrl_successWithoutDelay() {
        var dataTaskCompleted = false
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let statusCode = Int.random(in: 200...300)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.dataTask(with: url) { data, response, error in
            dataTaskCompleted = true
            XCTAssertNil(error)

            guard let httpResponse = response as? HTTPURLResponse else {
                XCTFail("Expected response to be casted to HTTPURLResponse and not to be nil")
                return
            }
            XCTAssertEqual(httpResponse.url, url)
            XCTAssertEqual(httpResponse.statusCode, statusCode)

            guard let data = data else {
                XCTFail("Expected data not to be nil")
                return
            }
            let string = String(data: data, encoding: .utf8)
            XCTAssertEqual(string, "{ }")
        }

        XCTAssertTrue(dataTaskCompleted)
    }

}
