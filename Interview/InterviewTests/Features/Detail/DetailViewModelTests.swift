//
//  DetailViewModelTests.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation
import XCTest
@testable import Interview

class DetailViewModelTests: XCTestCase {
    func testFetchPokemonDetailsSuccess() {
        let (sut, mockPokemonService, _) = makeSUT()
        let expectation = self.expectation(description: "Fetch pokemon details")
        
        let mockPokemon = Pokemon(
            id: 1,
            name: "Bulbasaur",
            height: 7,
            weight: 69,
            url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!
        )
        mockPokemonService.mockPokemonDetails = mockPokemon
        
        sut.onPokemonUpdated = { pokemon in
            XCTAssertEqual(pokemon.name, "Bulbasaur", "Pokemon name should be Bulbasaur")
            XCTAssertEqual(pokemon.number, "1", "Pokemon number should be 1")
            XCTAssertEqual(pokemon.height, "7", "Pokemon height should be 7")
            XCTAssertEqual(pokemon.weight, "69", "Pokemon weight should be 69")
            XCTAssertNotNil(pokemon.image, "Pokemon image should not be nil")
            expectation.fulfill()
        }
        
        sut.fetchPokemonDetail()
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchPokemonDetailsError() {
        let (sut, mockPokemonService, _) = makeSUT()
        let expectation = self.expectation(description: "Fetch pokemon details error")
        
        mockPokemonService.mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
        
        sut.onError = { error in
            XCTAssertNotNil(error, "Error should not be nil")
            expectation.fulfill()
        }
        
        sut.fetchPokemonDetail()
        
        waitForExpectations(timeout: 1.0)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: DetailViewModel, service: MockPokemonService, coordinator: MockDetailCoordinator) {
        let mockPokemonService = MockPokemonService()
        let mockCoordinator = MockDetailCoordinator()

        let sut = DetailViewModel(pokemonService: mockPokemonService, url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)
        sut.coordinator = mockCoordinator
        
        trackForMemoryLeaks(mockPokemonService, file: file, line: line)
        trackForMemoryLeaks(mockCoordinator, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, mockPokemonService, mockCoordinator)
    }
}
