# Ditto

Just like the pokémon, this app can take many forms.

This is my personal playground, where I test new stuff and get a better grip on old concepts.

This application is meant to be a host for all of my personal iOS projects from now on. 

Instead of having multiple little independent repositories, this repository will contain many little projects, mimicking how a large scale modular application would be built.

# Build Locally

To run this project, you'll need to install:
- [Cocoapods](https://github.com/CocoaPods/CocoaPods)
- [Buck](https://github.com/facebook/buck)

First, you need to run ```make update_cocoapods```, then you can choose between ```make build```; ```make debug``` and ```make test```, to, respectively, build the project; run the app in the iOS simulator; and run tests.

You can also run using Xcode. To generate the Xcode project files, run ```make project```, then you'll be able to run this project just like any other iOS project.

# Concepts

## Modularization

All projects will be separated into their own modules. For testing purposes, each module will have their own demo app, with stubbed responses. If accessed via the main app, no stubs will be used.

For build performance reasons, if a module is meant to be used as a dependency by other modules, it'll be divided into two modules:
- Interface - Like the name suggests, it exposes the interfaces.
- Implementation - Contains the actual implementation of said interfaces.

Other modules will only depend on the Interface modules. Dependency injection and routing will be handled by the main target using [RouterService](https://github.com/rockbruno/RouterService).

## Build tool

To take advantage of the modularization and achieve fast build times, we use [Buck](https://buck.build). 

The buck structure in this project is heavily based on [Airbnb's buck sample project](https://github.com/airbnb/BuckSample).

TODO: Setup a CI pipeline that takes advantage of buck's caching.

# Mini projects

Like said before, this project contains many mini projects:
- Networking - Custom Networking API, trying to make something similar to [Moya](https://github.com/Moya/Moya), without taking a look at the actual implementation. I might try to add GraphQL support in the future.
- Utilities - Random convenient stuff. Will try to add my own layout constraint DSL.
- [xkcd](https://xkcd.com) - Comics website, with a simple JSON API

And, in the future, might also contain:
- [PokeAPI](https://pokeapi.co) - A rich pokémon API, opens possibility for many mini projects. Also has a GraphQL API (still in beta).
- [NASA](https://api.nasa.gov) - Many APIs, particularly interested in 'Astronomy Picture of the Day' and 'Mars Rover Photos'.
- Weather - Simple weather app, but animation heavy.
- Stock Photos - [Unsplash](https://unsplash.com/developers), [Pexels](https://www.pexels.com/api/) and [Pixabay](https://pixabay.com/api/docs/) - An attempt at seamlessly integrating three diferent data sources.
- FPV Drone Camfeed - Still need to do some research on the communication protocol, might not be feasible.