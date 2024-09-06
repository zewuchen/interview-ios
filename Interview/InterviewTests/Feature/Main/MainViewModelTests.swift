//
//  MainViewModelTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class MainViewModelTests: XCTestCase {
    private let mainViewModelOutputSpy: MainViewModelOutputSpy = .init()
    private let pokemonWorkSpy: PokemonWorkerSpy = .init()
    private let pokemonRowRuleUseCaseSpy: PokemonRowBackgroundColorUseCaseSpy = .init()
    private lazy var sut: MainViewModel = .init(
        pokemonWorker: pokemonWorkSpy,
        pokemonRowBackgroundColorUserCase: pokemonRowRuleUseCaseSpy
    )
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut.setDelegate(mainViewModelOutputSpy)
    }
    
    func test_forCellReuseIdentifier_shouldReturnExpectedValue() throws {
        XCTAssertEqual(sut.forCellReuseIdentifier, "PokemonTableViewCell")
    }
    
    func test_fetchPokemons_wasCalledOnceWillLoadPokemon() throws {
        sut.fetchPokemons()
        
        XCTAssertEqual(sut.getPokemonList().isEmpty, true)
        XCTAssertEqual(mainViewModelOutputSpy.willLoadPokemonsVerifier.count, 1)
        XCTAssertEqual(
            mainViewModelOutputSpy.willLoadPokemonsVerifier.first,
            "Carregando"
        )
    }
    
    func test_fetchPokemons_whenFailure_wasCaledOnceLoadedPokemonsWithFailure() throws {
        pokemonWorkSpy.resultToBeReturned = .failure(.internalServerError)
        
        sut.fetchPokemons()
        
        XCTAssertEqual(sut.getPokemonList().isEmpty, true)
        XCTAssertEqual(mainViewModelOutputSpy.loadedPokemonsWithFailureVerifier, 1)
    }
    
    func test_fetchPokemons_whenSuccess_whenResultsIsNil_wasCaledOnceLoadedPokemonsWithFailure() throws {
        let response: PokemonCatalogResponse = .init(count: 0, results: nil)
        pokemonWorkSpy.resultToBeReturned = .success(response)
        
        sut.fetchPokemons()
        
        XCTAssertEqual(mainViewModelOutputSpy.loadedPokemonsWithFailureVerifier, 1)
        XCTAssertEqual(sut.getPokemonList().isEmpty, true)
    }
    
    func test_fetchPokemons_whenSuccess_whenResultsIsNotNil_and_shouldGetPokemonRowWithExpectedValues() throws {
        let results: PokemonEntityResponse = .init(name: "dummyName", url: "dummyUrl")
        let response: PokemonCatalogResponse = .init(count: 0, results: [results])
        pokemonWorkSpy.resultToBeReturned = .success(response)
        pokemonRowRuleUseCaseSpy.getRowBackgroundToBeReturned = .blue
        
        sut.fetchPokemons()
        
        XCTAssertEqual(
            sut.getPokemonList(),
            [
                PokemonRow(title: "1 - dummyName", background: .blue, url: URL(string: "dummyUrl"))
            ]
        )
    }
    
    func test_fetchPokemons_whenSuccess_whenNameIsNil_shouldNotAppendPokemonRow() throws {
        let results: PokemonEntityResponse = .init(name: nil, url: "dummyUrl")
        let response: PokemonCatalogResponse = .init(count: 0, results: [results])
        pokemonWorkSpy.resultToBeReturned = .success(response)
        
        sut.fetchPokemons()
        
        XCTAssertEqual(sut.getPokemonList().isEmpty, true)
    }
    
    func test_fetchPokemons_whenSuccess_whenUrlIsNil_shouldNotAppendPokemonRow() throws {
        let results: PokemonEntityResponse = .init(name: "dummyName", url: nil)
        let response: PokemonCatalogResponse = .init(count: 0, results: [results])
        pokemonRowRuleUseCaseSpy.getRowBackgroundToBeReturned = .blue
        pokemonWorkSpy.resultToBeReturned = .success(response)
        
        sut.fetchPokemons()
        
        XCTAssertEqual(
            sut.getPokemonList(),
            [PokemonRow(title: "1 - dummyName", background: .blue, url: nil)]
        )
        
        XCTAssertEqual(pokemonRowRuleUseCaseSpy.getRowBackgroundVerifier.count, 1)
    }
    
    func test_fetchPokemons_whenSuccess_whenResultsIsNotNil_wasCaledOnceLoadedPokemonsWithSuccess() throws {
        let results: PokemonEntityResponse = .init(name: "dummyName", url: "dummyUrl")
        let response: PokemonCatalogResponse = .init(count: 0, results: [results])
        pokemonWorkSpy.resultToBeReturned = .success(response)
        
        sut.fetchPokemons()
        
        XCTAssertEqual(mainViewModelOutputSpy.loadedPokemonsWithSuccessVerifier, 1)
    }
}
