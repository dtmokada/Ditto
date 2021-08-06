//
//  NWRequestTests.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 06/08/21.
//

import XCTest
@testable import NetworkingAPI

class NWRequestTests: XCTestCase {

    func testAsUrlRequest() throws {
        let host = NWHostStub(
            scheme: .https,
            baseURL: "apple.com"
        )
        let path = "/path"
        let queryItems = [
            URLQueryItem(name: "item1", value: "value1"),
            URLQueryItem(name: "item2", value: "value2")
        ]
        let httpMethod = HTTPMethod.put
        let timeoutInterval = 123.4
        let cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
        let headers = [
            "header1": "value1",
            "header2": "value2",
        ]
        let additionalHeaders = [
            "additionalHeader1": "value1",
            "additionalHeader2": "value2",
        ]
        let config = NWRequestConfig(
            timeoutInterval: timeoutInterval,
            cachePolicy: cachePolicy,
            additionalHeaders: additionalHeaders
        )
        let nwRequest = NWRequestStub(
            config: config,
            host: host,
            path: path,
            method: httpMethod,
            queryItems: queryItems,
            headers: headers,
            body: nil
        )

        let urlRequest = try XCTUnwrap(nwRequest.asURLRequest)

        XCTAssertEqual(urlRequest.url?.absoluteString, "https://apple.com/path?item1=value1&item2=value2")
        XCTAssertEqual(urlRequest.httpMethod, httpMethod.rawValue)
        XCTAssertEqual(urlRequest.timeoutInterval, timeoutInterval)
        XCTAssertEqual(urlRequest.cachePolicy, cachePolicy)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, headers.merging(additionalHeaders, uniquingKeysWith: { $0 + $1 }))
    }

    func testAsUrlRequest_invalidUrl() throws {
        let host = NWHostStub(
            scheme: .https,
            baseURL: "apple.com"
        )
        let path = "invalid_path"
        let queryItems = [
            URLQueryItem(name: "item1", value: "value1"),
            URLQueryItem(name: "item2", value: "value2")
        ]
        let httpMethod = HTTPMethod.put
        let timeoutInterval = 123.4
        let cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
        let headers = [
            "header1": "value1",
            "header2": "value2",
        ]
        let additionalHeaders = [
            "additionalHeader1": "value1",
            "additionalHeader2": "value2",
        ]
        let config = NWRequestConfig(
            timeoutInterval: timeoutInterval,
            cachePolicy: cachePolicy,
            additionalHeaders: additionalHeaders
        )
        let nwRequest = NWRequestStub(
            config: config,
            host: host,
            path: path,
            method: httpMethod,
            queryItems: queryItems,
            headers: headers,
            body: nil
        )

        let urlRequest = nwRequest.asURLRequest

        XCTAssertNil(urlRequest)
    }

}
