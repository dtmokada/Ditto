//
//  DependencyRegistration.swift
//  Ditto
//
//  Created by Daniel Okada on 03/08/21.
//

import Utilities
import NetworkingAPI
import Networking
import RouterServiceInterface
import XKCD

class DependencyRegistration: DependencyRegistrationProtocol {

    static func registerRouteHandlers(on routerService: RouterServiceRegistrationProtocol) {
        routerService.register(routeHandler: HomeRouteHandler())
        routerService.register(routeHandler: XKCDRouteHandler())
    }

    static func registerDependencyFactories(on routerService: RouterServiceRegistrationProtocol) {
        routerService.register(dependencyFactory: {
            return NWProvider()
        }, forType: NWProviderProtocol.self)
    }

}
