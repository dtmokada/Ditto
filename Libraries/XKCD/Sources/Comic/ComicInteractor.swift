//
//  ComicInteractor.swift
//  XKCD
//
//  Created by Daniel Okada on 11/07/21.
//

import Foundation
import NetworkingAPI

protocol ComicBusinessLogic: AnyObject {
    func fetchInitialComic()
    func fetchNextComic()
    func fetchPreviousComic()
    func fetchRandomComic()
    func fetchComic(number: Int)
}

enum ComicState {
    case first
    case nth
    case last
    case only
}

class ComicInteractor: ComicBusinessLogic {

    private let service: ComicServiceProtocol
    private let presenter: ComicPresentationLogic

    private(set) var lastComicNumber: Int?
    private(set) var currentComicNumber: Int
    private(set) var currentRequest: Cancellable?

    init(presenter: ComicPresentationLogic, service: ComicServiceProtocol) {
        self.presenter = presenter
        self.service = service
        self.currentComicNumber = 0
    }

    func fetchInitialComic() {
        presenter.presentComicState(.only)
        service.fetchInitialComic { [weak self] response in
            if let comic = try? response.get() {
                let number = comic.number
                self?.lastComicNumber = number
                self?.currentComicNumber = number
                self?.updateComicStates()
            }
            self?.handleComicResponse(response)
        }
    }

    func fetchNextComic() {
        fetchComic(number: currentComicNumber + 1)
    }

    func fetchPreviousComic() {
        fetchComic(number: currentComicNumber - 1)
    }

    func fetchRandomComic() {
        let randomNumber = Int.random(in: 1...(lastComicNumber ?? 1))
        fetchComic(number: randomNumber)
    }

    func fetchComic(number: Int) {
        currentComicNumber = number
        updateComicStates()
        currentRequest?.cancel()
        presenter.presentLoading(true)
        currentRequest = service.fetchComic(number: number, completion: handleComicResponse)
    }

    func updateComicStates() {
        presenter.presentNumber(currentComicNumber)
        switch (currentComicNumber, lastComicNumber) {
        case (1, 1):
            presenter.presentComicState(.only)
        case (1, _):
            presenter.presentComicState(.first)
        case (let x, let y) where x == y:
            presenter.presentComicState(.last)
        default:
            presenter.presentComicState(.nth)
        }
    }

    func handleComicResponse(_ response: Result<Comic, NWError>) {
        switch response {
        case .success(let comic):
            presenter.presentLoading(false)
            presenter.presentComic(comic)
        case .failure(let error):
            handleError(error)
        }
    }

    func handleError(_ error: NWError) {
        if case .underlying(_, let underlyingError as NSError) = error, underlyingError.code == -999 {
            return
        }
        presenter.presentLoading(false)
        presenter.presentError()
    }

}
