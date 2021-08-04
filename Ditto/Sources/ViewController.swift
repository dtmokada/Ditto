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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Main App"
        label.font = .preferredFont(forTextStyle: .largeTitle, compatibleWith: nil)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start XKCD module", for: .normal)
        button.addTarget(self, action: #selector(routeToXkcd), for: .touchUpInside)
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
        view.backgroundColor = .white

        view.addSubview(view: titleLabel, constraints: [
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
        ])

        view.addSubview(view: button, constraints: [
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
        ])
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

