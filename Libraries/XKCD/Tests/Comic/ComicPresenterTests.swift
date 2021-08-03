//
//  ComicPresenterTests.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

import XCTest
@testable import XKCD

class ComicPresenterTests: XCTestCase {

    var sut: ComicPresenter!
    var spy: ComicDisplayLogicSpy!

    override func setUpWithError() throws {
        spy = ComicDisplayLogicSpy()
        sut = ComicPresenter()
        sut.view = spy
    }

    func testPresentLoading() {
        sut.presentLoading(true)
        XCTAssertTrue(spy.displayLoadingCalled)
        XCTAssertEqual(spy.displayLoadingParameter, true)

        sut.presentLoading(false)
        XCTAssertTrue(spy.displayLoadingCalled)
        XCTAssertEqual(spy.displayLoadingParameter, false)
    }

    func testPresentComicState_firstComic() {
        let state = ComicState.first

        sut.presentComicState(state)

        XCTAssertTrue(spy.displayPreviousButtonEnabledCalled)
        XCTAssertEqual(spy.displayPreviousButtonEnabledParameter, false)

        XCTAssertTrue(spy.displayNextButtonEnabledCalled)
        XCTAssertEqual(spy.displayNextButtonEnabledParameter, true)
    }

    func testPresentComicState_nthComic() {
        let state = ComicState.nth

        sut.presentComicState(state)

        XCTAssertTrue(spy.displayPreviousButtonEnabledCalled)
        XCTAssertEqual(spy.displayPreviousButtonEnabledParameter, true)

        XCTAssertTrue(spy.displayNextButtonEnabledCalled)
        XCTAssertEqual(spy.displayNextButtonEnabledParameter, true)
    }

    func testPresentComicState_lastComic() {
        let state = ComicState.last

        sut.presentComicState(state)

        XCTAssertTrue(spy.displayPreviousButtonEnabledCalled)
        XCTAssertEqual(spy.displayPreviousButtonEnabledParameter, true)

        XCTAssertTrue(spy.displayNextButtonEnabledCalled)
        XCTAssertEqual(spy.displayNextButtonEnabledParameter, false)
    }

    func testPresentComicState_onlyComic() {
        let state = ComicState.only

        sut.presentComicState(state)

        XCTAssertTrue(spy.displayPreviousButtonEnabledCalled)
        XCTAssertEqual(spy.displayPreviousButtonEnabledParameter, false)

        XCTAssertTrue(spy.displayNextButtonEnabledCalled)
        XCTAssertEqual(spy.displayNextButtonEnabledParameter, false)
    }

    func testPresentNumber() {
        let number = 42389

        sut.presentNumber(number)

        XCTAssertTrue(spy.displayNumberCalled)
        XCTAssertEqual(spy.displayNumberParameter, number)
    }

    func testPresentComic() {
        let title = "Comic Title"
        let imageUrl = "https://validurl.com"
        let comic = Comic.fixture(title: title, imageUrl: imageUrl)

        sut.presentComic(comic)

        XCTAssertFalse(spy.displayGenericErrorCalled)
        XCTAssertTrue(spy.displayComicCalled)
        XCTAssertEqual(spy.displayComicParameters?.title, title)
        XCTAssertEqual(spy.displayComicParameters?.imageUrl.absoluteString, imageUrl)
    }

    func testPresentComic_invalidUrl() {
        let comic = Comic.fixture()

        sut.presentComic(comic)

        XCTAssertTrue(spy.displayGenericErrorCalled)
        XCTAssertFalse(spy.displayComicCalled)
    }

    func testPresentError() {
        sut.presentError()
        XCTAssertTrue(spy.displayGenericErrorCalled)
    }

}
