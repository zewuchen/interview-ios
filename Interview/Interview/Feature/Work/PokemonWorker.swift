//
//  PokemonWorker.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol PokemonMainWorker {
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void))
}

protocol PokemonDetailWorker {
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void))
}

protocol PokemonWorkerProtocol: PokemonMainWorker, PokemonDetailWorker {}

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
    
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void)) {
        guard let url = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = url.host else {
            return
        }
        
        let endpoint: Endpoint = PokemonDetailEndpoint(
            host: host,
            baseUrl: url.path
        )
        
        networker.request(endpoint: endpoint, completion: completion)
    }
}
