//
//  XKCDHost.swift
//  XKCD
//
//  Created by Daniel Okada on 30/07/21.
//

import NetworkingAPI

struct XKCDHost: NWHost {
    var scheme: HTTPScheme { .https }
    var baseURL: String { "xkcd.com" }
}
