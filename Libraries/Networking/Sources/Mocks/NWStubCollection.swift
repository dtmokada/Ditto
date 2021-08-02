//
//  NWStubCollection.swift
//  Networking
//
//  Created by Daniel Okada on 30/07/21.
//

import Foundation

public protocol NWStubCollection {
    static var bundle: Bundle { get }
    static var stubs: [NWStub] { get }
}

public extension NWStubCollection {
    static var bundle: Bundle { .main }
}
