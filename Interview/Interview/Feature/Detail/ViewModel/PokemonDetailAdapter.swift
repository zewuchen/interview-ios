//
//  PokemonDetailAdapter.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

struct PokemonDetailAdapter: PokemonDetailRow {
    let detailResponse: PokemonDetailResponse
    let imageAsset: String
    
    var id: String? {
        guard let id = detailResponse.id.toString() else { return nil }
        return "Número: \(id)"
    }
    
    var height: String? {
        guard let height = detailResponse.height.toString() else { return nil }
        return "Altura: \(height)"
    }
    
    var name: String? {
        guard let name = detailResponse.name?.capitalized else { return nil }
        return "Nome: \(name)"
    }
    
    var weigh: String? {
        guard let weigh = detailResponse.weight.toString() else { return nil }
        return "Peso: \(weigh)"
    }
}
