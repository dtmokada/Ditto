//
//  NWProviderTests.swift
//  NetworkingTests
//
//  Created by Daniel Okada on 05/08/21.
//

import XCTest
import NetworkingAPI
import NetworkingMock
@testable import Networking

class NWProviderTests: XCTestCase {

    var sut: NWProvider!
    var sessionMock: NWSessionMock!

    override func setUpWithError() throws {
        sessionMock = NWSessionMock()
        sut = NWProvider(urlSession: sessionMock)
        NWStubs.shared.responseDelay = nil
    }

    override func tearDownWithError() throws {
        NWStubs.shared.removeAllStubs()
    }

    func testRequest_success() {
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let statusCode = Int.random(in: 200...299)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.request(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.request, request)
                XCTAssertEqual(response.statusCode, statusCode)
                let string = String(data: response.data, encoding: .utf8)
                XCTAssertEqual(string, "{ }")
            case .failure:
                XCTFail("Request should succeed")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }

    func testRequest_failure() {
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)

        _ = sut.request(request: request) { result in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let nwError):
                if case let .underlying(_, error as NSError) = nwError {
                    XCTAssertEqual(error.code, 500)
                } else {
                    XCTFail("Error should be underlying")
                }
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }

    func testRequest_cancelled() {
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let statusCode = Int.random(in: 200...299)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "dummy.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )
        NWStubs.shared.responseDelay = 0.1

        let cancellable = sut.request(request: request) { result in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let nwError):
                if case let .underlying(_, error as NSError) = nwError {
                    XCTAssertEqual(error.code, -999)
                } else {
                    XCTFail("Error should be underlying")
                }
            }
            exp.fulfill()
        }

        cancellable.cancel()
        waitForExpectations(timeout: 1)
    }

    func testRequestDecodable_success() {
        let exp = expectation(description: #function)
        let baseUrl = "apple.com"
        let scheme = "https://"
        let statusCode = Int.random(in: 200...299)
        let request = NWRequestStub.fixture(
            host: NWHostStub.fixture(scheme: .https, baseURL: baseUrl)
        )
        NWStubs.shared.register(
            urlRegex: scheme + baseUrl,
            file: "dummy.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.request(request) { (result: Result<DummyModel, NWError>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.abc, "def")
            case .failure(let error):
                XCTFail("\(error)")
                XCTFail("Request should succeed")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }

    func testRequestDecodable_decodingError() {
        let exp = expectation(description: #function)
        let baseUrl = "apple.com"
        let scheme = "https://"
        let statusCode = Int.random(in: 200...299)
        let request = NWRequestStub.fixture(
            host: NWHostStub.fixture(scheme: .https, baseURL: baseUrl)
        )
        NWStubs.shared.register(
            urlRegex: scheme + baseUrl,
            file: "empty.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.request(request) { (result: Result<DummyModel, NWError>) in
            switch result {
            case .success:
                XCTFail("Decoding should fail")
            case .failure(let error):
                if case let .objectMapping(response, decodingError) = error {
                    XCTAssertEqual(response.statusCode, statusCode)
                    XCTAssertTrue(decodingError is DecodingError)
                } else {
                    XCTFail("Request returned wrong error type")
                }
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }

    func testRequestDecodable_invalidUrl() {
        let request = NWRequestStub.fixture(path: "...")

        _ = sut.request(request) { (result: Result<DummyModel, NWError>) in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let error):
                if case .invalidUrl = error {

                } else {
                    XCTFail("Request returned wrong error type")
                }
            }
        }
    }

    func testRequestImage_success() {
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let statusCode = Int.random(in: 200...299)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "ditto.png",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.requestImage(url: url, completion: { result in
            switch result {
            case .success(let image):
                XCTAssertEqual(image.size, CGSize(width: 475, height: 475))
            case .failure:
                XCTFail("Request should succeed")
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }

    func testRequestImage_decodingError() {
        let exp = expectation(description: #function)
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let statusCode = Int.random(in: 200...299)
        NWStubs.shared.register(
            urlRegex: urlString,
            file: "dummy.json",
            inBundle: Bundle(for: Self.self),
            statusCode: statusCode
        )

        _ = sut.requestImage(url: url, completion: { result in
            switch result {
            case .success:
                XCTFail("Decoding should fail")
            case .failure(let error):
                if case let .imageDecoding(response) = error {
                    XCTAssertEqual(response.statusCode, statusCode)
                } else {
                    XCTFail("Decoding returned wrong error type")
                }
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }

}
