//
//  NWProviderProtocol.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 12/07/21.
//

import Foundation
import UIKit

public protocol NWProviderProtocol {
    @discardableResult func request<T: Decodable>(_ request: NWRequest, completion: @escaping NWResult<T>) -> Cancellable
    @discardableResult func request<T: Decodable>(_ request: NWRequest, decoder: JSONDecoder, completion: @escaping NWResult<T>) -> Cancellable
    @discardableResult func requestImage(url: URL, completion: @escaping NWResult<UIImage>) -> Cancellable
}

public extension NWProviderProtocol {

    func request<T: Decodable>(_ request: NWRequest, completion: @escaping NWResult<T>)  -> Cancellable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return self.request(request, decoder: decoder, completion: completion)
    }

}
