//
//  Pokemon.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name: String
    let height: Int?
    let weight: Int?
    let url: URL?
}
