//
//  NWRequest.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 13/07/21.
//

import Foundation

public protocol NWRequest {
    var config: NWRequestConfig { get }
    var host: NWHost { get }

    var path: String { get }
    var method: HTTPMethod { get }

    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

public extension NWRequest {

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var headers: [String: String] {
        return [:]
    }
    var body: Data? {
        return nil
    }

    var asURLRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = host.scheme.rawValue
        components.host = host.baseURL
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let timeoutInterval = config.timeoutInterval {
            request.timeoutInterval = timeoutInterval
        }
        if let cachePolicy = config.cachePolicy {
            request.cachePolicy = cachePolicy
        }
        config.additionalHeaders?.forEach { (field, value) in
            request.addValue(value, forHTTPHeaderField: field)
        }
        headers.forEach { (field, value) in
            request.addValue(value, forHTTPHeaderField: field)
        }
        return request
    }

}
