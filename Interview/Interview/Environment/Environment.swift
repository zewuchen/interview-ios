//
//  Environment.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol EnvironmentProtocol {
    var host: String { get }
}

struct Environment {
    enum Host: EnvironmentProtocol {
        case pokeapi
        
        var host: String {
            return "https://pokeapi.co"
        }
    }
}
