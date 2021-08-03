//
//  Comic.swift
//  XKCD
//
//  Created by Daniel Okada on 09/07/21.
//

import UIKit

struct Comic: Decodable {

    enum CodingKeys: String, CodingKey {
        case day
        case month
        case year
        case title
        case imageUrl = "img"
        case number = "num"
    }

    let day: String
    let month: String
    let year: String

    let title: String
    let imageUrl: String

    let number: Int

}
