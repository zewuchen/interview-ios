//
//  PokemonDetailRow.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol PokemonDetailRow {
    var id: String? { get }
    var height: String? { get }
    var name: String? { get }
    var weigh: String? { get }
    var imageAsset: String { get }
}
