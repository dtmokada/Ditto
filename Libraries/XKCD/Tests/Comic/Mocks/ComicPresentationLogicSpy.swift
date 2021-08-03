//
//  ComicPresentationLogicSpy.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

import Foundation
@testable import XKCD

class ComicPresentationLogicSpy: ComicPresentationLogic {

    var presentLoadingCalled = false
    var presentLoadingParameter: Bool?
    func presentLoading(_ loading: Bool) {
        presentLoadingCalled = true
        presentLoadingParameter = loading
    }

    var presentComicStateCalled = false
    var presentComicStateParameter: ComicState?
    func presentComicState(_ state: ComicState) {
        presentComicStateCalled = true
        presentComicStateParameter = state
    }

    var presentNumberCalled = false
    var presentNumberParameter: Int?
    func presentNumber(_ number: Int) {
        presentNumberCalled = true
        presentNumberParameter = number
    }

    var presentComicCalled = false
    var presentComicParameter: Comic?
    func presentComic(_ comic: Comic) {
        presentComicCalled = true
        presentComicParameter = comic
    }

    var presentErrorCalled = false
    func presentError() {
        presentErrorCalled = true
    }

}
