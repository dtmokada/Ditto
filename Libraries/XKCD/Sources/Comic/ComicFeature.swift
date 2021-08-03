//
//  ComicFeature.swift
//  XKCD
//
//  Created by Daniel Okada on 30/07/21.
//

import UIKit
import RouterServiceInterface
import NetworkingAPI

struct ComicFeature: Feature {

    @Dependency var routerService: RouterServiceProtocol
    @Dependency var provider: NWProviderProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        let presenter = ComicPresenter()
        let service = ComicService(provider: provider)
        let interactor = ComicInteractor(presenter: presenter, service: service)
        let viewController = ComicViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }

}
