//
//  ComicViewController.swift
//  XKCD
//
//  Created by Daniel Okada on 09/07/21.
//

import UIKit
import Utilities
import NetworkingAPI

protocol ComicDisplayLogic: AnyObject {
    func displayLoading(_ loading: Bool)
    func displayPreviousButtonEnabled(_ enabled: Bool)
    func displayNextButtonEnabled(_ enabled: Bool)
    func displayNumber(_ number: Int)
    func displayComic(title: String, imageUrl: URL)
    func displayGenericError()
}

class ComicViewController: UIViewController {

    private lazy var navigationTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "XKCD Comics"
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(updateTitleViewSize), for: .allEditingEvents)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        toolbar.items = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(fetchComicWithNumber)),
        ]
        textField.inputAccessoryView = toolbar
        return textField
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "Loading..."
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.black.cgColor
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.isHidden = true
        return view
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        indicatorView.startAnimating()
        return indicatorView
    }()

    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.addTarget(self, action: #selector(fetchPreviousComic), for: .touchUpInside)
        return button
    }()

    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Random", for: .normal)
        button.addTarget(self, action: #selector(fetchRandomComic), for: .touchUpInside)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(fetchNextComic), for: .touchUpInside)
        return button
    }()

    private let interactor: ComicBusinessLogic

    init(interactor: ComicBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchInitialComic()
    }

    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.titleView = navigationTitleTextField

        view.addSubview(view: titleLabel, constraints: [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])

        view.addSubview(view: scrollView, constraints: [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])
        scrollView.addSubview(view: imageView, constraints: [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),

            imageView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, constant: -40),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: -40),
        ])
        view.addSubview(view: loadingView, constraints: [
            loadingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        loadingView.addSubview(view: activityIndicatorView, constraints: [
            activityIndicatorView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
        ])
        view.addSubview(view: previousButton, constraints: [
            previousButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            previousButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        view.addSubview(view: randomButton, constraints: [
            randomButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 8),
            randomButton.topAnchor.constraint(equalTo: previousButton.topAnchor),
            randomButton.bottomAnchor.constraint(equalTo: previousButton.bottomAnchor),
            randomButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor),
        ])
        view.addSubview(view: nextButton, constraints: [
            nextButton.leadingAnchor.constraint(equalTo: randomButton.trailingAnchor, constant: 8),
            nextButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            nextButton.topAnchor.constraint(equalTo: previousButton.topAnchor),
            nextButton.bottomAnchor.constraint(equalTo: previousButton.bottomAnchor),
            nextButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor),
        ])
    }

    private func fetchInitialComic() {
        interactor.fetchInitialComic()
    }

    @objc private func fetchPreviousComic() {
        interactor.fetchPreviousComic()
    }

    @objc private func fetchRandomComic() {
        interactor.fetchRandomComic()
    }

    @objc private func fetchNextComic() {
        interactor.fetchNextComic()
    }

    @objc private func fetchComicWithNumber() {
        navigationTitleTextField.resignFirstResponder()
        guard let number = Int(navigationTitleTextField.text ?? "") else {
            let alert = UIAlertController(title: "Can't load comic!", message: "Please input only numbers.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        navigationTitleTextField.placeholder = navigationTitleTextField.text
        navigationTitleTextField.text = ""
        interactor.fetchComic(number: number)
    }

    @objc private func updateTitleViewSize() {
        navigationTitleTextField.sizeToFit()
    }

}

extension ComicViewController: ComicDisplayLogic {

    func displayLoading(_ loading: Bool) {
        loadingView.isHidden = !loading
    }

    func displayPreviousButtonEnabled(_ enabled: Bool) {
        previousButton.isEnabled = enabled
    }

    func displayNextButtonEnabled(_ enabled: Bool) {
        nextButton.isEnabled = enabled
    }

    func displayNumber(_ number: Int) {
        navigationTitleTextField.placeholder = "\(number)"
        navigationTitleTextField.sizeToFit()
    }

    func displayComic(title: String, imageUrl: URL) {
        displayLoading(true)
        titleLabel.text = title
        imageView.setImage(url: imageUrl) { [weak self] in
            self?.displayLoading(false)
        }
    }

    func displayGenericError() {
        let alert = UIAlertController(title: "Failed to load comic!", message: "Try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
