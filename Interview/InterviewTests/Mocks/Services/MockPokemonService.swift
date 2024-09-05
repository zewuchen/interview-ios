//
//  MockPokemonService.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation
@testable import Interview

class MockPokemonService: PokemonService {
    var mockPokemonList: PokemonList?
    var mockPokemonDetail: Pokemon?

    func fetchPokemons(_ completion: @escaping (PokemonListResult) -> Void) {
        if let mockPokemonList = mockPokemonList {
            completion(.success(mockPokemonList))
        } else {
            completion(.failure(.emptyData))
        }
    }

    func fetchPokemonDetails(from url: URL, completion: @escaping (PokemonDetailsResult) -> Void) {
        if let mockPokemonDetail = mockPokemonDetail {
            completion(.success(mockPokemonDetail))
        } else {
            completion(.failure(.emptyData))
        }
    }
}
