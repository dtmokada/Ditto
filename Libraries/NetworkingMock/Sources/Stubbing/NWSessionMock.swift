//
//  NWSessionMock.swift
//  NetworkingMock
//
//  Created by Daniel Okada on 04/08/21.
//

import Foundation
import NetworkingAPI

extension DispatchWorkItem: Cancellable { }

public class NWSessionMock: NWSession {

    private let stubs: NWStubs
    private let responseQueue: DispatchQueue

    public init(
        stubs: NWStubs = .shared,
        responseQueue: DispatchQueue = .main
    ) {
        self.stubs = stubs
        self.responseQueue = responseQueue
    }

    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let workItem: DispatchWorkItem
        if let (data, statusCode) = stubs.dataFor(request: request), let url = request.url {
            let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            workItem = DispatchWorkItem(block: {
                completionHandler(data, response, nil)
            })
        } else {
            let userInfo = [
                NSLocalizedFailureReasonErrorKey: "Stub for \(request.url?.absoluteString ?? "") was not found",
            ]
            let error = NSError(domain: "Networking", code: 500, userInfo: userInfo)
            workItem = DispatchWorkItem(block: {
                completionHandler(nil, nil, error)
            })
        }
        if let delay = stubs.responseDelay {
            responseQueue.asyncAfter(deadline: .now() + delay) {
                if workItem.isCancelled {
                    let userInfo = [
                        NSLocalizedFailureReasonErrorKey: "Request was cancelled",
                    ]
                    let error = NSError(domain: "Networking", code: -999, userInfo: userInfo)
                    completionHandler(nil, nil, error)
                } else {
                    workItem.perform()
                }
            }
        } else {
            workItem.perform()
        }
        return workItem
    }

    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let request = URLRequest(url: url)
        return dataTask(with: request, completionHandler: completionHandler)
    }

}
