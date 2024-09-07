//
//  PokemonEndpointTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class PokemonEndpointTests: XCTestCase {

    func test_init() throws {
        let sut: PokemonEndpoint = .init()
        
        XCTAssertEqual(sut.host, "pokeapi.co")
        XCTAssertEqual(sut.baseUrl, "/api/v2/pokemon/")
        XCTAssertEqual(sut.method, .GET)
    }
}
