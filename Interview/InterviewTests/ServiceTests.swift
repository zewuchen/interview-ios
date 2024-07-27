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
var urlSession: URLSessionMock!
var cache: URLCache!
var userDefaults: UserDefaults!

override func setUp() {
    super.setUp()
    urlSession = URLSessionMock()
    cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: "pokemonCache")
    userDefaults = UserDefaults(suiteName: "TestDefaults")
    userDefaults.removePersistentDomain(forName: "TestDefaults")
    service = Service(urlSession: urlSession, cache: cache, userDefaults: userDefaults)
}

override func tearDown() {
    service = nil
    super.tearDown()
}

func testFetchData_withValidData_shouldReturnDecodedObject() {
    // Dado um JSON válido para ser retornado pela URLSessionMock
    let jsonData = """
    {
        "name": "Pikachu"
    }
    """.data(using: .utf8)!
    urlSession.data = jsonData
    urlSession.response = HTTPURLResponse(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    urlSession.error = nil
    
    let expectation = self.expectation(description: "Fetching data")
    
    service.fetchData(from: "https://pokeapi.co/api/v2/pokemon") { (result: Result<PokemonModel, Error>) in
        switch result {
        case .success(let pokemon):
            XCTAssertEqual(pokemon.name, "Pikachu")
        case .failure(let error):
            XCTFail("Expected success but got \(error) instead")
        }
        expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
}

// Outros testes aqui...
}

class URLSessionMock: URLSession {
var data: Data?
var response: URLResponse?
var error: Error?

override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return URLSessionDataTaskMock {
        completionHandler(self.data, self.response, self.error)
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
