//
//  PokemonDataModel.swift
//  Interview
//
//  Created by Kaled Jamal El Azanki on 02/07/24.
//

import Foundation

public struct PokemonDataModel: Decodable {
    var results: [Pokemons]
}

public struct Pokemons: Decodable {
    var name: String?
    var url: String?
}

public struct PokemonDetail: Decodable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
}
