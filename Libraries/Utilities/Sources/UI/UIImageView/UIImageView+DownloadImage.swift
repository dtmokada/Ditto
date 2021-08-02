//
//  UIImageView+DownloadImage.swift
//  Utilities
//
//  Created by Daniel Okada on 01/08/21.
//

import UIKit

public extension UIImageView {

    static var urlSession = URLSession.shared

    func setImage(url: URL, placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        if placeholder != nil {
            image = placeholder
        }
        let task = Self.urlSession.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    completion?()
                }
            }
        }
        task.resume()
    }

}
