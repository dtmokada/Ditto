//
//  NWRequestStub.swift
//  Networking
//
//  Created by Daniel Okada on 05/08/21.
//

import Foundation
import NetworkingAPI

struct NWRequestStub: NWRequest {

    let config: NWRequestConfig
    let host: NWHost

    let path: String
    let method: HTTPMethod

    let queryItems: [URLQueryItem]?
    let headers: [String: String]
    let body: Data?

}

extension NWRequestStub {

    static func fixture(
        config: NWRequestConfig = .init(),
        host: NWHost = NWHostStub.fixture(),
        path: String = "",
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        headers: [String : String] = [:],
        body: Data? = nil
    ) -> NWRequestStub {
        NWRequestStub(
            config: config,
            host: host,
            path: path,
            method: method,
            queryItems: queryItems,
            headers: headers,
            body: body
        )
    }

}
