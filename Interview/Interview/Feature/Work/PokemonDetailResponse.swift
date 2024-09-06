//
//  PokemonDetailResponse.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let id: Int?
    let height: Int?
    let name: String?
    let weight: Int?
}
