//
//  ViewController.swift
//  DemoApp
//
//  Created by Daniel Okada on 20/06/21.
//

import UIKit
import RouterServiceInterface
import XKCD

class ViewController: UIViewController {

    let routerService: RouterServiceProtocol

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next screen", for: .normal)
        button.addTarget(self, action: #selector(routeToNextScreen), for: .touchUpInside)
        return button
    }()

    init(routerService: RouterServiceProtocol) {
        self.routerService = routerService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func routeToNextScreen() {
        
    }
}

