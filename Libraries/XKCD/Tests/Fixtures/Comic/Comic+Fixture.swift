//
//  Comic+Fixture.swift
//  XKCDTests
//
//  Created by Daniel Okada on 03/08/21.
//

@testable import XKCD

extension Comic {

    static func fixture(
        day: String = "",
        month: String = "",
        year: String = "",
        title: String = "",
        imageUrl: String = "",
        number: Int = 0
    ) -> Comic {
        return Comic(
            day: day,
            month: month,
            year: year,
            title: title,
            imageUrl: imageUrl,
            number: number
        )
    }

}
