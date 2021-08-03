//
//  ComicPresenter.swift
//  XKCD
//
//  Created by Daniel Okada on 11/07/21.
//

import Foundation

protocol ComicPresentationLogic: AnyObject {
    func presentLoading(_ loading: Bool)
    func presentComicState(_ state: ComicState)
    func presentNumber(_ number: Int)
    func presentComic(_ comic: Comic)
    func presentError()
}

class ComicPresenter: ComicPresentationLogic {

    weak var view: ComicDisplayLogic?

    init() { }

    func presentLoading(_ loading: Bool) {
        view?.displayLoading(loading)
    }

    func presentComicState(_ state: ComicState) {
        switch state {
        case .first:
            view?.displayPreviousButtonEnabled(false)
            view?.displayNextButtonEnabled(true)
        case .nth:
            view?.displayPreviousButtonEnabled(true)
            view?.displayNextButtonEnabled(true)
        case .last:
            view?.displayPreviousButtonEnabled(true)
            view?.displayNextButtonEnabled(false)
        case .only:
            view?.displayPreviousButtonEnabled(false)
            view?.displayNextButtonEnabled(false)
        }
    }

    func presentNumber(_ number: Int) {
        view?.displayNumber(number)
    }

    func presentComic(_ comic: Comic) {
        guard let url = URL(string: comic.imageUrl) else {
            view?.displayGenericError()
            return
        }
        view?.displayComic(title: comic.title, imageUrl: url)
    }

    func presentError() {
        view?.displayGenericError()
    }

}
