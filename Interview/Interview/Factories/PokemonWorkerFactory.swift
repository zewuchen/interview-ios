//
//  PokemonWorkerFactory.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation

enum PokemonWorkerFactory {
    static func make() -> PokemonWorkerProtocol {
        let urlSession: URLSessionProtocol = URLSession.shared
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let environment: EnvironmentProtocol.Type = Environment.Host.self
        let networker: NetworkerProtocol = Networker(
            urlSession: urlSession,
            jsonNDecoder: jsonDecoder
        )
        
        let cacheWorker: CacheworkerProtocol = Cacheworker(urlCache: URLCacheFactory.shared.make())
        
        let serviceProxy: ServiceProxyProtocol = ServiceProxy(
            networker: networker,
            cacheWorker: cacheWorker
        )
        
        return PokemonWorker(
            serviceProxy: serviceProxy,
            environment: environment
        )
    }
}
