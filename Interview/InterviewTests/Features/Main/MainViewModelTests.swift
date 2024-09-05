//
//  MainViewModelTests.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import XCTest
@testable import Interview

class MainViewModelTests: XCTestCase {
    func testFetchAllPokemons() {
        let (sut, mockPokemonService, _) = makeSUT()

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
        
        waitForExpectations(timeout: 1.0)
    }

    func testDidSelectPokemon() {
        let (sut, mockPokemonService, coordinator) = makeSUT()
        let mockPokemons = [Pokemon(id: 1, name: "Bulbasaur", height: nil, weight: nil, url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)]
        mockPokemonService.mockPokemonList = PokemonList(results: mockPokemons)

        sut.fetchAllPokemons()
        sut.didSelectPokemon(at: 0)

        XCTAssertTrue(coordinator.showPokemonDetailsCalled)
        XCTAssertEqual(coordinator.url, mockPokemons[0].url)
    }
    
    func testFetchAllPokemonsError() {
        let (sut, mockPokemonService, _) = makeSUT()
        let expectation = self.expectation(description: "Fetch all pokemons error")
        
        mockPokemonService.mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
        
        sut.onError = { error in
            XCTAssertNotNil(error, "Error should not be nil")
            expectation.fulfill()
        }
        
        sut.fetchAllPokemons()
        
        waitForExpectations(timeout: 1.0)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut:MainViewModel, service: MockPokemonService, coordinator: MockMainCoordinator) {
        let mockPokemonService = MockPokemonService()
        let mockCoordinator = MockMainCoordinator()
        let sut = MainViewModel(pokemonService: mockPokemonService)
        sut.coordinator = mockCoordinator
        
        trackForMemoryLeaks(mockPokemonService, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(mockCoordinator, file: file, line: line)

        return (sut, mockPokemonService, mockCoordinator)
    }
}
