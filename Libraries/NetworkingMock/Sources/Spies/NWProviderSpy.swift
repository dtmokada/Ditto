//
//  NWProviderSpy.swift
//  NetworkingMock
//
//  Created by Daniel Okada on 03/08/21.
//

import UIKit
import NetworkingAPI

public class NWProviderSpy: NWProviderProtocol {

    public var callbackQueue: DispatchQueue

    public init(callbackQueue: DispatchQueue = .main) {
        self.callbackQueue = callbackQueue
    }

    public var requestCalled = false
    public var requestParameters: NWRequest?
    public var requestResponse: Decodable?
    public var requestError: NWError?
    public func request<T>(_ request: NWRequest, decoder: JSONDecoder, completion: @escaping NWResult<T>) -> Cancellable where T : Decodable {
        requestCalled = true
        requestParameters = request
        if let response = requestResponse as? T {
            completion(.success(response))
        } else {
            let error = requestError ?? .underlying(nil, NSError(domain: "NetworkingMock", code: 500, userInfo: nil))
            completion(.failure(error))
        }
        return DummyCancellable()
    }

    public var requestImageCalled = false
    public var requestImageParameters: URL?
    public var requestImageResponse: UIImage?
    public var requestImageError: NWError?
    public func requestImage(url: URL, completion: @escaping NWResult<UIImage>) -> Cancellable {
        requestCalled = true
        requestImageParameters = url
        if let response = requestImageResponse {
            completion(.success(response))
        } else {
            let error = requestImageError ?? .underlying(nil, NSError(domain: "NetworkingMock", code: 500, userInfo: nil))
            completion(.failure(error))
        }
        return DummyCancellable()
    }

}
