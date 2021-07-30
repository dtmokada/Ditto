//
//  NWResponse.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 12/07/21.
//

import Foundation

public class NWResponse {

    public let statusCode: Int
    public let data: Data
    public let request: URLRequest?
    public let response: HTTPURLResponse?

    public init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }

    public static func == (lhs: NWResponse, rhs: NWResponse) -> Bool {
        return lhs.statusCode == rhs.statusCode
            && lhs.data == rhs.data
            && lhs.response == rhs.response
    }

}

public extension NWResponse {

    func filter<Range: RangeExpression>(statusCodes: Range) throws -> NWResponse where Range.Bound == Int {
        guard statusCodes.contains(statusCode) else {
            throw NWError.statusCode(self)
        }
        return self
    }

    func filter(statusCode: Int) throws -> NWResponse {
        return try filter(statusCodes: statusCode...statusCode)
    }

    func filterSuccessfulStatusCodes() throws -> NWResponse {
        return try filter(statusCodes: 200...299)
    }

    func map<Dec: Decodable>(_ type: Dec.Type, using decoder: JSONDecoder = JSONDecoder()) throws -> Dec {
        do {
            return try decoder.decode(Dec.self, from: data)
        } catch {
            throw NWError.objectMapping(self, error)
        }
    }

}
