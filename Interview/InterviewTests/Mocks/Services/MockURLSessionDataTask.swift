//
//  MockURLSessionDataTask.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation
@testable import Interview

class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var dataTaskCallCount = 0
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        completionHandler(mockData, mockResponse, mockError)
        return MockURLSessionDataTask(completionHandler: completionHandler)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func resume() {
        // In a real implementation, you might want to add a delay here to simulate network latency
        // For now, we'll just call the completion handler immediately
        completionHandler(nil, nil, nil)
    }
}
