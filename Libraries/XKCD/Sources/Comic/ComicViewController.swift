//
//  ComicViewController.swift
//  XKCD
//
//  Created by Daniel Okada on 09/07/21.
//

import UIKit
import Utilities
import NetworkingAPI

protocol ComicDisplayLogic: AnyObject {
    func displayLoading(_ loading: Bool)
    func displayPreviousButtonEnabled(_ enabled: Bool)
    func displayNextButtonEnabled(_ enabled: Bool)
    func displayNumber(_ number: Int)
    func displayComic(title: String, imageUrl: URL)
    func displayGenericError()
}
