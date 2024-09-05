//
//  UrlSessionSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import XCTest
@testable import Interview

final class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    private(set) var resumeVerifier: Int = 0
    
    func resume() {
        resumeVerifier += 1
    }
}

final class UrlSessionSpy: URLSessionProtocol {
    var urlSessionToBeReturned: URLSessionDataTaskSpy = .init()
    var dataToBeReturned: Data?
    var urlResponseToBeReturned: URLResponse?
    var errorToBeReturned: Error?
    private(set) var dataTaskVerifier: [URLRequest] = []
    
    func dataTask(
        request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, (Error)?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTaskVerifier.append(request)
        completionHandler(dataToBeReturned, urlResponseToBeReturned, errorToBeReturned)
        return urlSessionToBeReturned
    }
    
    func verifyArgumentsToDataTask(
        request: URLRequest,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(dataTaskVerifier.first?.url, request.url, file: file, line: line)
        XCTAssertEqual(dataTaskVerifier.first?.httpMethod, request.httpMethod, file: file, line: line)
    }
}
