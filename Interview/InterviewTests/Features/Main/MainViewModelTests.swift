//
//  MainViewModelTests.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import XCTest
@testable import Interview

class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    var mockPokemonService: MockPokemonService!
    var mockCoordinator: MockMainCoordinator!

    override func setUp() {
        super.setUp()
        mockPokemonService = MockPokemonService()
        mockCoordinator = MockMainCoordinator()
        sut = MainViewModel(pokemonService: mockPokemonService)
        sut.coordinator = mockCoordinator
    }

    override func tearDown() {
        sut = nil
        mockPokemonService = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testFetchAllPokemons() {
        let expectation = self.expectation(description: "Fetch all pokemons")
        let mockPokemons = [Pokemon(id: 1, name: "Bulbasaur", height: nil, weight: nil, url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)]
        mockPokemonService.mockPokemonList = PokemonList(results: mockPokemons)

        sut.onPokemonsUpdated = { pokemons in
            XCTAssertEqual(pokemons.count, 1)
            XCTAssertEqual(pokemons[0].title, "1 - Bulbasaur")
            XCTAssertEqual(pokemons[0].type, .blue)
            expectation.fulfill()
        }

        sut.fetchAllPokemons()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDidSelectPokemon() {
        let mockPokemons = [Pokemon(id: 1, name: "Bulbasaur", height: nil, weight: nil, url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)]
        mockPokemonService.mockPokemonList = PokemonList(results: mockPokemons)

        sut.fetchAllPokemons()
        sut.didSelectPokemon(at: 0)

        XCTAssertTrue(mockCoordinator.showPokemonDetailsCalled)
        XCTAssertEqual(mockCoordinator.url, mockPokemons[0].url)
    }
}
