//
//  PokeAPI.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

protocol PokemonService {
    func fetchPokemons(_ completion: @escaping ([PokemonList]) -> Void)
}

struct PokeApi: PokemonService {

    private var serviceManager: APIServiceProtocol

    init(serviceManager: APIServiceProtocol = APIService()) {
        self.serviceManager = serviceManager
    }

    func fetchPokemons(_ completion: @escaping ([PokemonList]) -> Void) {
        serviceManager.get(request: Router.allPokemons.getRequest,
                           of: [PokemonList].self) { result in
            switch result {
            case .success(let pokemons):
                completion(pokemons)
            case .failure:
                completion([])
            }
        }
    }
}
