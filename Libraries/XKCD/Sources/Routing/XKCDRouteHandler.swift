//
//  XKCDRouteHandler.swift
//  XKCD
//
//  Created by Daniel Okada on 30/07/21.
//

import UIKit
import RouterServiceInterface

public final class XKCDRouteHandler: RouteHandler {

    public init() { }

    public var routes: [Route.Type] {
        return [XKCDInitialRoute.self]
    }

    public func destination(forRoute route: Route, fromViewController viewController: UIViewController) -> Feature.Type {
        return ComicFeature.self
    }

}
