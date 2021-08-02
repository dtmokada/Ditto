//
//  NWStub.swift
//  Networking
//
//  Created by Daniel Okada on 01/08/21.
//

import Foundation

public struct NWStub {

    public let urlRegex: String
    public let file: String
    public let statusCode: Int

    public init(urlRegex: String, file: String, statusCode: Int = 200) {
        self.urlRegex = urlRegex
        self.file = file
        self.statusCode = statusCode
    }

}
