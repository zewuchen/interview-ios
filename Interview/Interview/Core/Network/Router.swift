//
//  Router.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

enum Router {

    case allPokemons

    static private let baseURL: String = "https://pokeapi.co/api/v2/"

    var url: URL {
        URL(string: Self.baseURL+self.path)!
    }

    private var path: String {
        switch self {
        case .allPokemons:
            return "pokemon"
        }
    }

    var getRequest: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
        return request
    }
}
