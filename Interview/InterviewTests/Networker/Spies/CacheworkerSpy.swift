//
//  CacheworkerSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 07/09/24.
//

import Foundation
import XCTest
@testable import Interview

final class CacheworkerSpy<R: Decodable>: CacheworkerProtocol {
    private(set) var requestVerifier: [Endpoint] = []
    private(set) var storeCachedResponseVerifier: [(urlResponse: URLResponse, urlRequest: URLRequest, data: Data)] = []
    var resultToBeReturned: Result<R, NetworkerError>?
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping ((Result<T, NetworkerError>) -> Void)
    ) {
        requestVerifier.append(endpoint)
        guard let result = resultToBeReturned as? Result<T, NetworkerError> else {
            XCTFail("resultToBeReturned must be casting with Result<T, NetworkerError>")
            return
        }
        
        completion(result)
    }
    
    func storeCachedResponse(_ urlResponse: URLResponse, for urlRequest: URLRequest, data: Data) {
        storeCachedResponseVerifier.append((urlResponse, urlRequest, data))
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
