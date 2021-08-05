//
//  NWSession.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 04/08/21.
//

import Foundation

public protocol NWSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable
}

extension URLSessionDataTask: Cancellable { }

extension URLSession: NWSession {

    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let task: URLSessionDataTask = dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        }
        task.resume()
        return task
    }

    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let task: URLSessionDataTask = dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        }
        task.resume()
        return task
    }

}
