//
//  DependencyRegistration.swift
//  DemoApp
//
//  Created by Daniel Okada on 03/08/21.
//

import UIKit
import Utilities
import NetworkingAPI
import Networking
import NetworkingMock
import RouterServiceInterface
import XKCD

class DependencyRegistration: DependencyRegistrationProtocol {

    static func registerRouteHandlers(on routerService: RouterServiceRegistrationProtocol) {
        routerService.register(routeHandler: XKCDRouteHandler())
    }

    static func registerDependencyFactories(on routerService: RouterServiceRegistrationProtocol) {
        routerService.register(dependencyFactory: {
            let provider = NWProvider(urlSession: NWSessionMock())
            return provider
        }, forType: NWProviderProtocol.self)
    }

    static func registerStubs() {
        UIImageView.networkingSession = NWSessionMock()
        NWStubs.shared.responseDelay = 1
        NWStubs.shared.register(stubCollection: ComicStubCollection.self)
    }

}
