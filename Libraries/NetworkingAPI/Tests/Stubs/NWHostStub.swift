//
//  NWHostStub.swift
//  Networking
//
//  Created by Daniel Okada on 05/08/21.
//

import Foundation
import NetworkingAPI

struct NWHostStub: NWHost {
    let scheme: HTTPScheme
    let baseURL: String
}

extension NWHostStub {

    static func fixture(
        scheme: HTTPScheme = .https,
        baseURL: String = ""
    ) -> NWHostStub {
        NWHostStub(
            scheme: scheme,
            baseURL: baseURL
        )
    }

}
