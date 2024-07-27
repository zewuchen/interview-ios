//
//  ServiceTests.swift
//  InterviewTests
//
//  Created by Caio Cesar de Oliveira on 26/07/24.
//

import XCTest
@testable import Interview

class ServiceTests: XCTestCase {

    var service: Service!
    var urlSessionMock: URLSessionMock!
    var cacheMock: URLCacheMock!
    var userDefaultsMock: UserDefaultsMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        urlSessionMock = URLSessionMock()
        cacheMock = URLCacheMock()
        userDefaultsMock = UserDefaultsMock()

        service = Service(urlSession: urlSessionMock, cache: cacheMock, userDefaults: userDefaultsMock)
    }

    override func tearDownWithError() throws {
        service = nil
        urlSessionMock = nil
        cacheMock = nil
        userDefaultsMock = nil
        try super.tearDownWithError()
    }

    func testGetPokemonSuccess() throws {
        // Mock data
        let pokemonData = PokemonModel(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25")
        let data = try JSONEncoder().encode(pokemonData)
        
        urlSessionMock.data = data

        let expectation = self.expectation(description: "Fetch Pokemon")

        service.getPokemon { result in
            switch result {
            case .success(let pokemon):
                XCTAssertEqual(pokemon.name, "Pikachu")
            case .failure(let error):
                XCTFail("Expected success, got \(error) instead")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Mock Classes
    class URLSessionMock: URLSession {
        var data: Data?
        var error: Error?

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return URLSessionDataTaskMock {
                completionHandler(self.data, nil, self.error)
            }
        }
    }

    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void

        init(closure: @escaping () -> Void) {
            self.closure = closure
        }

        override func resume() {
            closure()
        }
    }

    class URLCacheMock: URLCache {
        var cachedResponse: CachedURLResponse?

        override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
            return cachedResponse
        }

        override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
            self.cachedResponse = cachedResponse
        }
    }

    class UserDefaultsMock: UserDefaults {
        private var storage = [String: Any]()

        override func data(forKey defaultName: String) -> Data? {
            return storage[defaultName] as? Data
        }

        override func set(_ value: Any?, forKey defaultName: String) {
            storage[defaultName] = value
        }
    }

    // Models for testing
    struct PokemonModel: Codable {
        let name: String
        let url: String
    }

    struct PokemonDetail: Codable {
        let name: String
        let weight: Int
    }
    
    // Endpoints for testing
    struct PokemonEndPoint {
        static let getPokemonUrl = "https://pokeapi.co/api/v2/pokemon"
    }
}