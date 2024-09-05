//
//  PokemonCatalogResponse.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

struct PokemonEntityResponse: Decodable, Equatable {
    let name: String?
    let url: String?
}

struct PokemonCatalogResponse: Decodable, Equatable {
    let count: Int?
    let results: [PokemonEntityResponse]?
}

