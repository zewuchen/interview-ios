//
//  MainViewModelTests.swift
//  InterviewTests
//
//  Created by Caio Cesar de Oliveira on 26/07/24.
//

import XCTest
@testable import Interview

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var mockService: MockService!
    var mockDelegate: MockMainViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = MainViewModel(service: mockService)
        mockDelegate = MockMainViewModelDelegate()
        viewModel.viewDelegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testFetchPokemonDataSuccess() {
        // Arrange
        let expectedPokemonList = [Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/25/")]
        mockService.result = .success(PokemonResponse(results: expectedPokemonList))
        
        // Act
        viewModel.fetchPokemonData()
        
        // Assert
        XCTAssertEqual(viewModel.getNumberOfRowsInSection(), expectedPokemonList.count)
        XCTAssertTrue(mockDelegate.isFetchPokemonDataSuccessCalled)
    }
    
    func testFetchPokemonDataFailure() {
        // Arrange
        let expectedError = NSError(domain: "test", code: 1, userInfo: nil)
        mockService.result = .failure(expectedError)
        
        // Act
        viewModel.fetchPokemonData()
        
        // Assert
        XCTAssertTrue(mockDelegate.isFetchPokemonDataFailureCalled)
        XCTAssertEqual(mockDelegate.fetchError as NSError?, expectedError)
    }
    
    func testGetNumberOfRowsInSection() {
        // Arrange
        let expectedPokemonList = [Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/25/")]
        viewModel.pokemonList = expectedPokemonList
        
        // Act
        let numberOfRows = viewModel.getNumberOfRowsInSection()
        
        // Assert
        XCTAssertEqual(numberOfRows, expectedPokemonList.count)
    }
    
    func testGetPokemon() {
        // Arrange
        let expectedPokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/25/")
        viewModel.pokemonList = [expectedPokemon]
        
        // Act
        let pokemonRowModel = viewModel.getPokemon(for: 0)
        
        // Assert
        XCTAssertEqual(pokemonRowModel.name, "1 - Bulbasaur")
        XCTAssertEqual(pokemonRowModel.url, expectedPokemon.url)
    }
    
    func testPrepareBackground() {
        // Arrange & Act
        let color1 = viewModel.prepareBackground(1)
        let color2 = viewModel.prepareBackground(2)
        let color10 = viewModel.prepareBackground(10)
        
        // Assert
        XCTAssertEqual(color1.backgroundColor, UIColor.blue)
        XCTAssertEqual(color1.textColor, UIColor.white)
        
        XCTAssertEqual(color2.backgroundColor, UIColor.yellow)
        XCTAssertEqual(color2.textColor, UIColor.black)
        
        XCTAssertEqual(color10.backgroundColor, UIColor.red)
        XCTAssertEqual(color10.textColor, UIColor.white)
    }
}

class MockService: Service {
    
    var result: Result<PokemonResponse, Error>?
    
    override func getPokemon(completion: @escaping (Result<PokemonResponse, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

class MockMainViewModelDelegate: MainViewModelDelegate {
    
    var isFetchPokemonDataSuccessCalled = false
    var isFetchPokemonDataFailureCalled = false
    var fetchError: Error?
    
    func fetchPokemonDataSuccess() {
        isFetchPokemonDataSuccessCalled = true
    }
    
    func fetchPokemonDataFailure(error: Error) {
        isFetchPokemonDataFailureCalled = true
        fetchError = error
    }
}
