//
//  ComicRequest.swift
//  XKCD
//
//  Created by Daniel Okada on 30/07/21.
//

import NetworkingAPI

struct ComicRequest: NWRestRequest {

    var host: NWHost {
        return XKCDHost()
    }

    var path: String {
        return "/\(number)/info.0.json"
    }

    var method: HTTPMethod {
        return .get
    }

    let number: Int

    init(number: Int) {
        self.number = number
    }

}
