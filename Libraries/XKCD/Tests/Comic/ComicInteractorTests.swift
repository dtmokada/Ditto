//
//  ComicInteractorTests.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

import XCTest
import Networking
import NetworkingMock
@testable import XKCD

class ComicInteractorTests: XCTestCase {

    var sut: ComicInteractor!
    var presenterSpy: ComicPresentationLogicSpy!
    var serviceMock: ComicService!

    override func setUpWithError() throws {
        presenterSpy = ComicPresentationLogicSpy()
        serviceMock = ComicService(provider: NWProvider(urlSession: NWSessionMock()))
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock)

        NWStubs.shared.register(
            urlRegex: "https://xkcd.com/info.0.json",
            file: "comic_3.json",
            inBundle: Bundle(for: Self.self),
            statusCode: 200
        )
        NWStubs.shared.register(
            urlRegex: "https://xkcd.com/1/info.0.json",
            file: "comic_1.json",
            inBundle: Bundle(for: Self.self),
            statusCode: 200
        )
        NWStubs.shared.register(
            urlRegex: "https://xkcd.com/2/info.0.json",
            file: "comic_2.json",
            inBundle: Bundle(for: Self.self),
            statusCode: 200
        )
        NWStubs.shared.register(
            urlRegex: "https://xkcd.com/3/info.0.json",
            file: "comic_3.json",
            inBundle: Bundle(for: Self.self),
            statusCode: 200
        )
    }

    override func tearDownWithError() throws {
        NWStubs.shared.removeAllStubs()
    }

    func testFetchInitialComic_success() {
        sut.fetchInitialComic()

        XCTAssertTrue(presenterSpy.presentComicCalled)
        XCTAssertFalse(presenterSpy.presentErrorCalled)
        XCTAssertTrue(presenterSpy.presentComicStateCalled)
        XCTAssertEqual(presenterSpy.presentComicStateParameter, .last)
        XCTAssertEqual(sut.lastComicNumber, 3)
        XCTAssertEqual(sut.currentComicNumber, 3)
    }

    func testFetchInitialComic_error() {
        NWStubs.shared.removeStubFor(urlRegex: "https://xkcd.com/info.0.json")

        sut.fetchInitialComic()

        XCTAssertFalse(presenterSpy.presentComicCalled)
        XCTAssertTrue(presenterSpy.presentErrorCalled)
        XCTAssertTrue(presenterSpy.presentComicStateCalled)
        XCTAssertEqual(presenterSpy.presentComicStateParameter, .only)
        XCTAssertNil(sut.lastComicNumber)
        XCTAssertEqual(sut.currentComicNumber, 0)
    }

    func testFetchNextComic_success() {
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock, currentComicNumber: 1)

        sut.fetchNextComic()

        XCTAssertTrue(presenterSpy.presentComicCalled)
        XCTAssertFalse(presenterSpy.presentErrorCalled)
        XCTAssertTrue(presenterSpy.presentComicStateCalled)
        XCTAssertEqual(presenterSpy.presentComicStateParameter, .nth)
        XCTAssertEqual(sut.currentComicNumber, 2)
    }

    func testFetchNextComic_error() {
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock, currentComicNumber: 1)
        NWStubs.shared.removeStubFor(urlRegex: "https://xkcd.com/2/info.0.json")

        sut.fetchNextComic()

        XCTAssertFalse(presenterSpy.presentComicCalled)
        XCTAssertTrue(presenterSpy.presentErrorCalled)
        XCTAssertEqual(sut.currentComicNumber, 2)
    }

    func testFetchPreviousComic_success() {
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock, currentComicNumber: 2)

        sut.fetchPreviousComic()

        XCTAssertTrue(presenterSpy.presentComicCalled)
        XCTAssertFalse(presenterSpy.presentErrorCalled)
        XCTAssertTrue(presenterSpy.presentComicStateCalled)
        XCTAssertEqual(presenterSpy.presentComicStateParameter, .first)
        XCTAssertEqual(sut.currentComicNumber, 1)
    }

    func testFetchPreviousComic_error() {
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock, currentComicNumber: 2)
        NWStubs.shared.removeStubFor(urlRegex: "https://xkcd.com/1/info.0.json")

        sut.fetchPreviousComic()

        XCTAssertFalse(presenterSpy.presentComicCalled)
        XCTAssertTrue(presenterSpy.presentErrorCalled)
        XCTAssertEqual(sut.currentComicNumber, 1)
    }

    func testFetchRandomComic() {
        let lastComicNumber = 10
        sut = ComicInteractor(presenter: presenterSpy, service: serviceMock, lastComicNumber: lastComicNumber)

        for _ in 0...1000 {
            sut.fetchRandomComic()
            XCTAssertTrue((1...lastComicNumber).contains(sut.currentComicNumber))
        }
    }

}
