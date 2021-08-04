//
//  ViewController.swift
//  Ditto
//
//  Created by Daniel Okada on 01/07/21.
//

import UIKit
import RouterServiceInterface
import XKCD

class ViewController: UIViewController {

    let routerService: RouterServiceProtocol

    init(routerService: RouterServiceProtocol) {
        self.routerService = routerService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    @objc private func routeToXkcd() {
        routerService.navigate(
            toRoute: XKCDInitialRoute(),
            fromView: self,
            presentationStyle: Push(),
            animated: true
        )
    }
}

