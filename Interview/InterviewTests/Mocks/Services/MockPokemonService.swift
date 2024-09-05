//
//  MockPokemonService.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation
@testable import Interview

class MockPokemonService: PokemonServiceProtocol {
    var mockError: Error?

    var mockPokemonList: PokemonList?
    var mockPokemonDetails: Pokemon?
    
    func fetchPokemons(_ completion: @escaping (Result<PokemonList, ServiceError>) -> Void) {
        if let error = mockError {
            completion(.failure(.requestFailed(description: error.localizedDescription)))
        } else if let pokemonList = mockPokemonList {
            completion(.success(pokemonList))
        }
    }
    
    func fetchPokemonDetails(from url: URL, completion: @escaping (Result<Pokemon, ServiceError>) -> Void) {
        if let error = mockError {
            completion(.failure(.requestFailed(description: error.localizedDescription)))
        } else if let pokemonDetails = mockPokemonDetails {
            completion(.success(pokemonDetails))
        }
    }
}
