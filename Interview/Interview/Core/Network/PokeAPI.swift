//
//  PokeAPI.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

protocol PokemonServiceProtocol {
    typealias PokemonListResult = Result<PokemonList,ServiceError>
    typealias PokemonDetailsResult = Result<Pokemon, ServiceError>

    func fetchPokemons(_ completion: @escaping (PokemonListResult) -> Void)
    func fetchPokemonDetails(from url: URL, completion: @escaping (PokemonDetailsResult) -> Void)
}

struct PokeApi: PokemonServiceProtocol {
    
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
    
    func fetchPokemonDetails(from url: URL, completion: @escaping (PokemonDetailsResult) -> Void) {
        let request = URLRequest(url: url)

        serviceManager.get(request: request, of: Pokemon.self) { result in
            switch result {
            case .success(let pokemonDetail):
                completion(.success(pokemonDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
