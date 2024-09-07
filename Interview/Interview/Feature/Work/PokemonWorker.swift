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
    private let serviceProxy: ServiceProxyProtocol
    private let environment: EnvironmentProtocol.Type
    
    init(serviceProxy: ServiceProxyProtocol, environment: EnvironmentProtocol.Type) {
        self.serviceProxy = serviceProxy
        self.environment = environment
    }
    
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        let endpoint: Endpoint = PokemonEndpoint()
        
        serviceProxy.request(endpoint: endpoint, completion: completion)
    }
    
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void)) {
        guard let url = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = url.host else {
            completion(.failure(.parseError))
            return
        }
        
        let endpoint: Endpoint = PokemonDetailEndpoint(
            host: host,
            baseUrl: url.path
        )
        
        serviceProxy.request(endpoint: endpoint, completion: completion)
    }
}
