//
//  NetworkerSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import XCTest
@testable import Interview

final class NetworkerSpy<R: Decodable>: NetworkerProtocol {
    private(set) var requestVerifier: [Endpoint] = []
    var resultToBeReturned: Result<R, NetworkerError>?
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        cachePolicy: URLRequest.CachePolicy,
        completion: @escaping ((Result<T, NetworkerError>) -> Void)
    ) {
        requestVerifier.append(endpoint)
        guard let result = resultToBeReturned as? Result<T, NetworkerError> else {
            XCTFail("resultToBeReturned must be casting with Result<T, NetworkerError>")
            return
        }
        
        completion(result)
    }
    
    func verifyArgumentsToRequest(
        endpoint: Endpoint,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(requestVerifier.first?.baseUrl, endpoint.baseUrl, file: file, line: line)
        XCTAssertEqual(requestVerifier.first?.host, endpoint.host, file: file, line: line)
        XCTAssertEqual(requestVerifier.first?.method, endpoint.method, file: file, line: line)
    }
}
