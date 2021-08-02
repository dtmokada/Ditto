//
//  MockURLProtocol.swift
//  Networking
//
//  Created by Daniel Okada on 29/07/21.
//

import Foundation

public extension URLSession {

    static var mock: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return session
    }

}

class MockURLProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let responseDelay = NWStubs.shared.responseDelay
        let backgroundQueue = DispatchQueue.global(qos: .background)
        if let (data, statusCode) = NWStubs.shared.dataFor(request: request), let url = request.url {
            let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            backgroundQueue.asyncAfter(deadline: .now() + responseDelay) {
                self.client?.urlProtocolDidFinishLoading(self)
            }
        } else {
            let userInfo = [
                NSLocalizedFailureReasonErrorKey: "Stub for \(request.url?.absoluteString ?? "") was not found",
            ]
            let error = NSError(domain: "Networking", code: 500, userInfo: userInfo)
            backgroundQueue.asyncAfter(deadline: .now() + responseDelay) {
                self.client?.urlProtocol(self, didFailWithError: error)
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
    }

    override func stopLoading() {

    }

}
