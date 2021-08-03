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
