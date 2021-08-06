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

}

public extension Result where Success: NWResponse, Failure == NWError {

    func filter<Range: RangeExpression>(statusCodes: Range) -> Self where Range.Bound == Int {
        return flatMap { response in
            guard statusCodes.contains(response.statusCode) else {
                return .failure(NWError.statusCode(response))
            }
            return .success(response)
        }
    }

    func filter(statusCode: Int) -> Self {
        return filter(statusCodes: statusCode...statusCode)
    }

    func filterSuccessfulStatusCodes() -> Self {
        return filter(statusCodes: 200...299)
    }

    func map<Dec: Decodable>(_ type: Dec.Type, using decoder: JSONDecoder = JSONDecoder()) -> Result<Dec, NWError> {
        let mappedResult = flatMap { response -> Result<Dec, NWError> in
            do {
                let decodedResponse = try decoder.decode(Dec.self, from: response.data)
                return .success(decodedResponse)
            } catch {
                return .failure(NWError.objectMapping(response, error))
            }
        }
        return mappedResult
    }

}
