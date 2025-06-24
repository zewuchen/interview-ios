//
//  MockAPIService.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation
@testable import Interview

class MockAPIService: APIServiceProtocol {
    var mockResult: Result<Decodable, ServiceError>?

    func get<T: Decodable>(request: URLRequest, of type: T.Type, completion: @escaping (Result<T, ServiceError>) -> Void) {
        if let mockResult = mockResult as? Result<T, ServiceError> {
            completion(mockResult)
        } else {
            completion(.failure(.emptyData))
        }
    }
}
