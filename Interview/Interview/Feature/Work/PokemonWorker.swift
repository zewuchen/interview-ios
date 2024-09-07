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
    private let cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    private let serviceProxy: NetworkerProtocol
    private let environment: EnvironmentProtocol.Type
    
    init(serviceProxy: NetworkerProtocol, environment: EnvironmentProtocol.Type) {
        self.serviceProxy = serviceProxy
        self.environment = environment
    }
    
    func fetchPokemons(completion: @escaping ((Result<PokemonCatalogResponse, NetworkerError>) -> Void)) {
        let endpoint: Endpoint = PokemonEndpoint()
        
        serviceProxy.request(endpoint: endpoint, cachePolicy: cachePolicy, completion: completion)
    }
    
    func fetchPokemonDetail(url: URL, completion: @escaping ((Result<PokemonDetailResponse, NetworkerError>) -> Void)) {
        guard let url = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = url.host else {
            return
        }
        
        let endpoint: Endpoint = PokemonDetailEndpoint(
            host: host,
            baseUrl: url.path
        )
        
        serviceProxy.request(endpoint: endpoint, cachePolicy: cachePolicy, completion: completion)
    }
}
