//
//  ComicDisplayLogicSpy.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

import Foundation
@testable import XKCD

class ComicDisplayLogicSpy: ComicDisplayLogic {

    var displayLoadingCalled = false
    var displayLoadingParameter: Bool?
    func displayLoading(_ loading: Bool) {
        displayLoadingCalled = true
        displayLoadingParameter = loading
    }

    var displayPreviousButtonEnabledCalled = false
    var displayPreviousButtonEnabledParameter: Bool?
    func displayPreviousButtonEnabled(_ enabled: Bool) {
        displayPreviousButtonEnabledCalled = true
        displayPreviousButtonEnabledParameter = enabled
    }

    var displayNextButtonEnabledCalled = false
    var displayNextButtonEnabledParameter: Bool?
    func displayNextButtonEnabled(_ enabled: Bool) {
        displayNextButtonEnabledCalled = true
        displayNextButtonEnabledParameter = enabled
    }

    var displayNumberCalled = false
    var displayNumberParameter: Int?
    func displayNumber(_ number: Int) {
        displayNumberCalled = true
        displayNumberParameter = number
    }

    var displayComicCalled = false
    var displayComicParameters: (title: String, imageUrl: URL)?
    func displayComic(title: String, imageUrl: URL) {
        displayComicCalled = true
        displayComicParameters = (title, imageUrl)
    }

    var displayGenericErrorCalled = false
    func displayGenericError() {
        displayGenericErrorCalled = true
    }

}
