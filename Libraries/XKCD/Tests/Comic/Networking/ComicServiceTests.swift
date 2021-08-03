//
//  ComicServiceTests.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

import XCTest
import NetworkingMock
@testable import XKCD

class ComicServiceTests: XCTestCase {

    var sut: ComicService!
    var spy: NWProviderSpy!

    override func setUpWithError() throws {
        spy = NWProviderSpy()
        sut = ComicService(provider: spy)
    }

    func testFetchInitialComic_success() throws {
        let exp = expectation(description: #function)
        spy.requestResponse = Comic.fixture()

        sut.fetchInitialComic { result in
            let comic = try? result.get()
            XCTAssertNotNil(comic)
            exp.fulfill()
        }

        let request = try XCTUnwrap(spy.requestParameters)
        XCTAssertTrue(request is InitialComicRequest)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchInitialComic_error() throws {
        let exp = expectation(description: #function)
        spy.requestError = .invalidUrl

        sut.fetchInitialComic { result in
            let comic = try? result.get()
            XCTAssertNil(comic)
            exp.fulfill()
        }

        let request = try XCTUnwrap(spy.requestParameters)
        XCTAssertTrue(request is InitialComicRequest)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchComic_success() throws {
        let exp = expectation(description: #function)
        let number = 1
        spy.requestResponse = Comic.fixture()

        _ = sut.fetchComic(number: number) { result in
            let comic = try? result.get()
            XCTAssertNotNil(comic)
            exp.fulfill()
        }

        let request = try XCTUnwrap(spy.requestParameters as? ComicRequest)
        XCTAssertEqual(request.number, number)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchComic_error() throws {
        let exp = expectation(description: #function)
        let number = 999
        spy.requestError = .invalidUrl

        _ = sut.fetchComic(number: number) { result in
            let comic = try? result.get()
            XCTAssertNil(comic)
            exp.fulfill()
        }

        let request = try XCTUnwrap(spy.requestParameters as? ComicRequest)
        XCTAssertEqual(request.number, number)

        waitForExpectations(timeout: 1, handler: nil)
    }

}
