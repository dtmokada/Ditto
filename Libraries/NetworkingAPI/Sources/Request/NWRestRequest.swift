//
//  NWRestRequest.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 16/07/21.
//

import Foundation

public protocol NWRestRequest: NWRequest { }

extension NWRestRequest {

    public var config: NWRequestConfig {
        return .init(
            additionalHeaders: [
                "Accept": "application/json",
                "Content-Type": "application/json",
            ]
        )
    }

}
