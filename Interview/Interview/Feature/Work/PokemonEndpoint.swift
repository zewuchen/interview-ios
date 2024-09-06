//
//  PokemonEndpoint.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

struct PokemonEndpoint: Endpoint {
    let host: String = Environment.Host.pokeapi.host
    let baseUrl: String = "/api/v2/pokemon/"
    let method: HTTPMethod = .GET
}

struct PokemonDetailEndpoint: Endpoint {
    var method: HTTPMethod = .GET
    var host: String
    var baseUrl: String
}
