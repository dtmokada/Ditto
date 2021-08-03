//
//  ComicStubCollection.swift
//  DemoApp
//
//  Created by Daniel Okada on 30/07/21.
//

import NetworkingMock

struct ComicStubCollection: NWStubCollection {

    static var stubs: [NWStub] {
        [
            .init(
                urlRegex: "https://xkcd.com/info.0.json",
                file: "comic_3.json"
            ),
            .init(
                urlRegex: "https://xkcd.com/\\d*[1456789]/info.0.json",
                file: "comic_1.json"
            ),
            .init(
                urlRegex: "https://xkcd.com/\\d*2/info.0.json",
                file: "comic_2.json"
            ),
            .init(
                urlRegex: "https://xkcd.com/\\d*[03]/info.0.json",
                file: "comic_3.json"
            ),
            .init(
                urlRegex: "https://imgs.xkcd.com/comics/git_commit.png",
                file: "git_commit.png"
            ),
            .init(
                urlRegex: "https://imgs.xkcd.com/comics/tab_explosion.png",
                file: "tab_explosion.png"
            ),
            .init(
                urlRegex: "https://imgs.xkcd.com/comics/laws_of_physics.png",
                file: "laws_of_physics.png"
            ),
        ]
    }

}
