//
//  MainFeature.swift
//  DemoApp
//
//  Created by Daniel Okada on 29/06/21.
//

import UIKit
import RouterServiceInterface

struct MainFeature: Feature {

    @Dependency var routerService: RouterServiceProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        return ViewController(routerService: routerService)
    }

}

struct MainRoute: Route {
    static let identifier: String = "main"
}

final class MainRouteHandler: RouteHandler {

    public var routes: [Route.Type] {
        return [MainRoute.self]
    }

    public func destination(forRoute route: Route, fromViewController viewController: UIViewController) -> Feature.Type {
        return MainFeature.self
    }

}
