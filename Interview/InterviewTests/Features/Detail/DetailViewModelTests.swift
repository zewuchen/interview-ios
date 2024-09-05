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
    var sut: DetailViewModel!
    var mockPokemonService: MockPokemonService!
    var mockCoordinator: MockDetailCoordinator!

    override func setUp() {
        super.setUp()
        mockPokemonService = MockPokemonService()
        mockCoordinator = MockDetailCoordinator()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1")!
        sut = DetailViewModel(pokemonService: mockPokemonService, url: url)
        sut.coordinator = mockCoordinator
    }

    override func tearDown() {
        sut = nil
        mockPokemonService = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testFetchPokemonDetail() {
        let expectation = self.expectation(description: "Fetch pokemon detail")
        let mockPokemon = Pokemon(id: 1, name: "Bulbasaur", height: 7, weight: 69, url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)
        mockPokemonService.mockPokemonDetail = mockPokemon

        sut.onPokemonUpdated = { modelView in
            XCTAssertEqual(modelView.name, "Bulbasaur")
            XCTAssertEqual(modelView.number, "1")
            XCTAssertEqual(modelView.height, "7")
            XCTAssertEqual(modelView.weight, "69")
            XCTAssertNotNil(modelView.image)
            expectation.fulfill()
        }

        sut.fetchPokemonDetail()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
