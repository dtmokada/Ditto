//
//  HomeFeature.swift
//  DittoLibrary
//
//  Created by Daniel Okada on 02/08/21.
//

import UIKit
import RouterServiceInterface

struct HomeFeature: Feature {

    @Dependency var routerService: RouterServiceProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        return ViewController(routerService: routerService)
    }

}

struct HomeRoute: Route {
    static let identifier: String = "ditto:home"
}

final class HomeRouteHandler: RouteHandler {

    public var routes: [Route.Type] {
        return [HomeRoute.self]
    }

    public func destination(forRoute route: Route, fromViewController viewController: UIViewController) -> Feature.Type {
        return HomeFeature.self
    }

}
