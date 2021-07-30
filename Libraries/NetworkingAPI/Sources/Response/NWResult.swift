//
//  NWResult.swift
//  NetworkingAPI
//
//  Created by Daniel Okada on 29/07/21.
//

public typealias NWResult<T> = (Result<T, NWError>) -> Void
