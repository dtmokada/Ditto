//
//  Cancellable.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 29/07/21.
//

public protocol Cancellable {
    func cancel()
}

public class DummyCancellable: Cancellable {
    public init() {}
    public func cancel() {}
}
