//
//  PokemonWorkerSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import XCTest
@testable import Interview

final class PokemonWorkerSpy: PokemonWorkerProtocol {
    private(set) var fetchPokemonsVerifier: Int = 0
    private(set) var fetchPokemonDetailVerifier: [URL] = []
    
    var resultFetchPokemonsToBeReturned: Result<PokemonCatalogResponse, NetworkerError> = .failure(.badRequest)
    var resultFetchPokemonDetailToBeReturned: Result<PokemonDetailResponse, NetworkerError> = .failure(.badRequest)
    
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        fetchPokemonsVerifier += 1
        completion(resultFetchPokemonsToBeReturned)
    }
    
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void)) {
        fetchPokemonDetailVerifier.append(url)
        completion(resultFetchPokemonDetailToBeReturned)
    }
}
