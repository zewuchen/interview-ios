//
//  PokemonModel.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation

public struct PokemonModel: Decodable {
    var results: [Pokemon]
}

public struct Pokemon: Decodable {
    var name: String?
    var url: String?
}

public struct PokemonDetail: Decodable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
}

public enum PokemonsImage: String {
    case squirtle
    case bulbasaur
    case charmander
}
