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

