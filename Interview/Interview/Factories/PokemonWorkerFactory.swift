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
        
        return PokemonWorker(
            networker: networker,
            environment: environment
        )
    }
}
