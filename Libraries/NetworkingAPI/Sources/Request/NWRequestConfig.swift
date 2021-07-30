//
//  NWRequestConfig.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 16/07/21.
//

import Foundation

public struct NWRequestConfig {

    let timeoutInterval: TimeInterval?
    let cachePolicy: URLRequest.CachePolicy?
    let additionalHeaders: [String: String]?

    public init(timeoutInterval: TimeInterval? = nil, cachePolicy: URLRequest.CachePolicy? = nil, additionalHeaders: [String : String]? = nil) {
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
        self.additionalHeaders = additionalHeaders
    }

}
