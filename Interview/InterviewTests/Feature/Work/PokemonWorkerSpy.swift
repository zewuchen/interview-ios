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
    var resultToBeReturned: Result<PokemonCatalogResponse, NetworkerError> = .failure(.badRequest)
    
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        completion(resultToBeReturned)
    }
}
