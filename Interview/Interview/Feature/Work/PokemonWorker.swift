//
//  PokemonWorker.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol PokemonWorkerProtocol {
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void))
}

final class PokemonWorker: PokemonWorkerProtocol {
    private let networker: NetworkerProtocol
    private let environment: EnvironmentProtocol.Type
    
    init(networker: NetworkerProtocol, environment: EnvironmentProtocol.Type) {
        self.networker = networker
        self.environment = environment
    }
    
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        let endpoint: Endpoint = PokemonEndpoint()
        
        networker.request(endpoint: endpoint, completion: completion)
    }
}
