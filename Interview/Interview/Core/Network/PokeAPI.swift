//
//  PokeAPI.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

protocol PokemonService {
    typealias PokemonListResult = Result<PokemonList,ServiceError>
    func fetchPokemons(_ completion: @escaping (PokemonListResult) -> Void)
}

struct PokeApi: PokemonService {
    
    private var serviceManager: APIServiceProtocol

    init(serviceManager: APIServiceProtocol = APIService()) {
        self.serviceManager = serviceManager
    }

    func fetchPokemons(_ completion: @escaping (PokemonListResult) -> Void) {
        serviceManager.get(request: Router.allPokemons.getRequest,
                           of: PokemonList.self) { result in
            switch result {
            case .success(let pokemonList):
                completion(.success(pokemonList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
