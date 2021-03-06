//
//  NWProvider.swift
//  Networking
//
//  Created by Daniel Okada on 12/07/21.
//

import UIKit
import Foundation
import NetworkingAPI

public class NWProvider: NWProviderProtocol {

    private let urlSession: NWSession

    public init(urlSession: NWSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func request(request: URLRequest, completion: @escaping NWResult<NWResponse>)  -> Cancellable {
        return urlSession.dataTask(with: request) { (data, urlResponse, error) in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                let error = error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
                completion(.failure(.underlying(nil, error)))
                return
            }

            let response = NWResponse(
                statusCode: httpResponse.statusCode,
                data: data ?? Data(),
                request: request,
                response: httpResponse
            )
            completion(.success(response))
        }
    }

    @discardableResult
    public func request<T: Decodable>(_ request: NWRequest, decoder: JSONDecoder, completion: @escaping NWResult<T>)  -> Cancellable {
        guard let urlRequest = request.asURLRequest else {
            completion(.failure(.invalidUrl))
            return DummyCancellable()
        }
        return self.request(request: urlRequest) { result in
            let mappedResult = result.map(T.self)
            completion(mappedResult)
        }
    }

    @discardableResult
    public func requestImage(url: URL, completion: @escaping NWResult<UIImage>)  -> Cancellable {
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        return request(request: urlRequest) { result in
            let mappedResult = result.flatMap { response -> Result<UIImage, NWError> in
                guard let image = UIImage(data: response.data) else {
                    return .failure(NWError.imageDecoding(response))
                }
                return .success(image)
            }
            completion(mappedResult)
        }
    }

}
