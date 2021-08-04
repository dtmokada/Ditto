//
//  DependencyRegistration.swift
//  Utilities
//
//  Created by Daniel Okada on 01/08/21.
//

import RouterServiceInterface

public protocol DependencyRegistrationProtocol {
    static func registerDependencies(on routerService: RouterServiceRegistrationProtocol)
    static func registerRouteHandlers(on routerService: RouterServiceRegistrationProtocol)
    static func registerDependencyFactories(on routerService: RouterServiceRegistrationProtocol)
    static func registerStubs()
}

public extension DependencyRegistrationProtocol {

    static func registerDependencies(on routerService: RouterServiceRegistrationProtocol) {
        registerRouteHandlers(on: routerService)
        registerDependencyFactories(on: routerService)
        registerStubs()
    }

    static func registerStubs() { }

}
