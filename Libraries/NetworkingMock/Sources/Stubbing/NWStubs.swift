//
//  NWStubs.swift
//  Networking
//
//  Created by Daniel Okada on 30/07/21.
//

import Foundation

public class NWStubs {

    public static var shared = NWStubs()

    public var responseDelay: TimeInterval?

    private(set) var stubs: [String: (URL, Int)]

    init(responseDelay: TimeInterval? = nil, stubs: [String: (URL, Int)] = [:]) {
        self.responseDelay = responseDelay
        self.stubs = stubs
    }

    public func register(stubCollection: NWStubCollection.Type) {
        stubCollection.stubs.forEach { stub in
            register(urlRegex: stub.urlRegex, file: stub.file, inBundle: stubCollection.bundle, statusCode: stub.statusCode)
        }
    }

    @discardableResult
    public func register(urlRegex: String, file: String, inBundle bundle: Bundle, statusCode: Int) -> Bool {
        guard let path = bundle.path(forResource: file, ofType: nil) else { return false }
        stubs[urlRegex] = (URL(fileURLWithPath: path), statusCode)
        return true
    }

    public func removeStubFor(urlRegex: String) {
        stubs.removeValue(forKey: urlRegex)
    }

    public func removeAllStubs() {
        stubs.removeAll()
    }

    public func dataFor(request: URLRequest) -> (Data, Int)? {
        let url = request.url?.absoluteString ?? ""
        let firstMatch = stubs.keys.first { regex in
            let range = url.range(of: regex, options: .regularExpression)
            return range?.lowerBound == url.startIndex && range?.upperBound == url.endIndex
        }
        guard let key = firstMatch,
              let (fileUrl, statusCode) = stubs[key],
              let data = try? Data(contentsOf: fileUrl)
            else { return nil }
        return (data, statusCode)
    }

}
