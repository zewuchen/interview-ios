//
//  NetworkerTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class NetworkerTests: XCTestCase {
    private let dummyCachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private let cacheWorkerSpy: CacheworkerSpy<DummyResponse> = .init()
    private let urlSessionDataTaskSpy: URLSessionDataTaskSpy = .init()
    private let urlSessionSpy: UrlSessionSpy = .init()
    private lazy var sut: Networker = .init(
        urlSession: urlSessionSpy,
        jsonNDecoder: JSONDecoder()
    )
    
    func test_request_whenURLRequestIsNil_shouldGetFailure_and_shouldNotCallUrlSession() throws {
        let dummyEndpoint: DummyEndpoint = .init(host: " ", baseUrl: " invalid")
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.unknown("URLRequest is nil")))
        }
        
        XCTAssertTrue(urlSessionSpy.dataTaskVerifier.isEmpty)
        XCTAssertEqual(urlSessionDataTaskSpy.resumeVerifier, 0)
    }

    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNil_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        urlSessionSpy.urlResponseToBeReturned = nil
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.unknown("HTTPURLResponse is nil")))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
    }
    
    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNotNil_whenStatusCodeLessThan200_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        urlSessionSpy.urlResponseToBeReturned = try givemHTTPURLResponse(statusCode: 10)
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.unknown(nil)))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
    }
    
    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNotNil_whenStatusCodeGreatherThan300_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        urlSessionSpy.urlResponseToBeReturned = try givemHTTPURLResponse(statusCode: 500)
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.internalServerError))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
    }
    
    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNotNil_whenStatusCode200_whenDataIsNil_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        urlSessionSpy.urlResponseToBeReturned = try givemHTTPURLResponse(statusCode: 200)
        urlSessionSpy.dataToBeReturned = nil
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.unknown("Data is nil")))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
    }
    
    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNotNil_whenStatusCode200_whenDataIsNotNil_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyData: Data = try JSONEncoder().encode(DummyResponse(dummy: "dummy"))
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        let dummyURLResponse: URLResponse? = try givemHTTPURLResponse(statusCode: 200)
        urlSessionSpy.urlResponseToBeReturned = dummyURLResponse
        urlSessionSpy.dataToBeReturned = dummyData
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .success(DummyResponse(dummy: "dummy")))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.data, dummyData)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.urlRequest.url, dummyURLRequest.url)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.urlResponse, dummyURLResponse)
    }
    
    func test_request_whenURLRequestIsNotNil_whenURLResponseIsNotNil_whenStatusCode200_whenDataIsNotParse_shouldGetFailure_and_shouldCallUrlSession() throws {
        let dummyData: Data = try XCTUnwrap("".data(using: .utf8))
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLRequest: URLRequest = .init(url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")))
        let dummyURLResponse: URLResponse? = try givemHTTPURLResponse(statusCode: 200)
        urlSessionSpy.urlResponseToBeReturned = dummyURLResponse
        urlSessionSpy.dataToBeReturned = dummyData
        
        sut.request(endpoint: dummyEndpoint, cacheWorker: cacheWorkerSpy) { result in
            let result: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(result, .failure(.parseError))
        }
        
        urlSessionSpy.verifyArgumentsToDataTask(request: dummyURLRequest)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.data, dummyData)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.urlRequest.url, dummyURLRequest.url)
        XCTAssertEqual(cacheWorkerSpy.storeCachedResponseVerifier.first?.urlResponse, dummyURLResponse)
    }
    
    private func givemHTTPURLResponse(statusCode: Int) throws -> HTTPURLResponse? {
        return HTTPURLResponse(
            url: try XCTUnwrap(URL(string: "www.dummy.com")),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
    }
}

