//
//  ComicService.swift
//  XKCD
//
//  Created by Daniel Okada on 11/07/21.
//

import NetworkingAPI

protocol ComicServiceProtocol {
    func fetchInitialComic(completion: @escaping NWResult<Comic>)
    @discardableResult func fetchComic(number: Int, completion: @escaping NWResult<Comic>) -> Cancellable
}

class ComicService: ComicServiceProtocol {

    let provider: NWProviderProtocol

    init(provider: NWProviderProtocol) {
        self.provider = provider
    }

    func fetchInitialComic(completion: @escaping NWResult<Comic>) {
        let request = InitialComicRequest()
        provider.request(request, completion: completion)
    }

    func fetchComic(number: Int, completion: @escaping NWResult<Comic>) -> Cancellable {
        let request = ComicRequest(number: number)
        return provider.request(request, completion: completion)
    }

}
