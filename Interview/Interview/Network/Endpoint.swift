//
//  Endpoint.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

enum HTTPMethod: String {
    case GET = "get"
}

protocol Endpoint {
    var host: String { get }
    var baseUrl: String { get }
    var method: HTTPMethod { get }
}

protocol URLEndpoint: Endpoint {
    var url: URL { get }
}
