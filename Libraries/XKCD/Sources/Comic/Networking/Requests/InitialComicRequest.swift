//
//  InitialComicRequest.swift
//  XKCD
//
//  Created by Daniel Okada on 30/07/21.
//

import NetworkingAPI

struct InitialComicRequest: NWRestRequest {

    var host: NWHost {
        return XKCDHost()
    }

    var path: String {
        return "/info.0.json"
    }

    var method: HTTPMethod {
        return .get
    }

}
