//
//  NWError.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 12/07/21.
//

import Foundation

public enum NWError: Error {
    case objectMapping(NWResponse, Error)
    case encodableMapping(Error)
    case statusCode(NWResponse)
    case requestMapping(String)
    case parameterEncoding(Error)
    case imageDecoding(NWResponse)
    case underlying(NWResponse?, Error)
    case invalidUrl
}
