//
//  NWStubs+Fixture.swift
//  NetworkingMockTests
//
//  Created by Daniel Okada on 02/08/21.
//

import XCTest
@testable import NetworkingMock

extension NWStubs {

    static func fixture(responseDelay: TimeInterval = 0, stubs: [String : (URL, Int)] = [:]) -> NWStubs {
        return NWStubs(responseDelay: responseDelay, stubs: stubs)
    }

}
