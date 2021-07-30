//
//  NWHost.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 16/07/21.
//

import Foundation

public protocol NWHost {
    var scheme: HTTPScheme { get }
    var baseURL: String { get}
}
