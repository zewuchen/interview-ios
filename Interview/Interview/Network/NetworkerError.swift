//
//  NetworkerError.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

enum NetworkerError: Error, Equatable {
    case clientError
    case notFound
    case parseError
    case badRequest
    case unauthorized
    case forbidden
    case requestTimeout
    case internalServerError
    case unknown(String?)
}

extension NetworkerError {
    init(_ statusCode: Int, reason: String? = nil) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405, 406, 407, 409..<500: self = .clientError
        case 408: self = .requestTimeout
        case 500..<600: self = .internalServerError
        default: self = .unknown(reason)
        }
    }
}
