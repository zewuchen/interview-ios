//
//  ServiceError.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

enum ServiceError: Error {
    case requestFailed(description: String)
    case emptyData
    case decodeError

    var localizedDescription: String {
        switch self {
        case .emptyData:
            return "No error was received but we also don't have data."
        case .requestFailed(description: let description):
            return "Could not run request because: \(description)"
        case .decodeError:
            return "Could not decoded result"
        }
    }
}
