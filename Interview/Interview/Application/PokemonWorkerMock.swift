//
//  PokemonWorkerMock.swift
//  Interview
//
//  Created by Rafael Ramos on 08/09/24.
//

import Foundation

final class PokemonWorkerMock: PokemonWorkerProtocol {
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        let results: [PokemonEntityResponse] = [
            .init(name: "Name 1", url: "www.dummy.com")
        ]
        
        let response: PokemonCatalogResponse = .init(count: results.count, results: results)
        completion(.success(response))
    }
    
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void)) {
        let response: PokemonDetailResponse = .init(
            id: 123,
            height: 70,
            name: "Mock Pokemon Name 1",
            weight: 55
        )
        
        completion(.success(response))
    }
}
