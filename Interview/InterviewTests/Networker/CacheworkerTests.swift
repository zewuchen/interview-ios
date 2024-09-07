//
//  CacheworkerTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 07/09/24.
//

import XCTest
@testable import Interview

final class MockURLCache: URLCache {
    var cachedURLResponseToBeReturned: CachedURLResponse?
    var cachedData: Data?
    
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return cachedURLResponseToBeReturned
    }
    
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        cachedData = cachedResponse.data
    }
}

final class CacheworkerTests: XCTestCase {
    
    private let mockCache: MockURLCache = MockURLCache()
    private lazy var sut: Cacheworker = .init(
        urlCache: mockCache,
        jsonDecoder: JSONDecoder()
    )
    
    override func tearDownWithError() throws {
        mockCache.removeAllCachedResponses()
        try super.tearDownWithError()
    }
    
    func test_storeCachedResponse() throws {
        let dummyURLRequest: URLRequest = URLRequest(url: URL(string: "www.dummy.com")!)
        let dummyData: Data = try JSONEncoder().encode(DummyResponse(dummy: "dummy"))
        
        sut.storeCachedResponse(URLResponse(), for: dummyURLRequest, data: dummyData)
        
        XCTAssertEqual(mockCache.cachedData, dummyData)
    }
    
    func test_request_whenCachedResponseIsNotNil_shouldReturnSuccess() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLResponse: URLResponse = .init()
        let dummyData: Data = try JSONEncoder().encode(DummyResponse(dummy: "dummy"))
        let dummyCacheURLResponse: CachedURLResponse = .init(response: dummyURLResponse, data: dummyData)
        
        mockCache.cachedURLResponseToBeReturned = dummyCacheURLResponse
        
        sut.request(endpoint: dummyEndpoint) { result in
            let sutResult: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(sutResult, .success(DummyResponse(dummy: "dummy")))
        }
    }
    
    func test_request_whenCachedResponseIsNil_shouldReturnFailure() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLResponse: URLResponse = .init()
        let dummyData: Data = try JSONEncoder().encode(DummyResponse(dummy: "dummy"))
        
        mockCache.cachedURLResponseToBeReturned = nil
        
        sut.request(endpoint: dummyEndpoint) { result in
            let sutResult: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(sutResult, .failure(.notFound))
        }
    }
    
    func test_request_whenCachedResponseNotParsed_shouldReturnFailure() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        let dummyURLResponse: URLResponse = .init()
        let dummyData: Data = try JSONEncoder().encode("")
        let dummyCacheURLResponse: CachedURLResponse = .init(response: dummyURLResponse, data: dummyData)
        
        mockCache.cachedURLResponseToBeReturned = dummyCacheURLResponse
        
        sut.request(endpoint: dummyEndpoint) { result in
            let sutResult: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(sutResult, .failure(.parseError))
        }
    }
    
    func test_request_whenCachedURLRequestIsInValid_shouldReturnFailure() throws {
        let dummyEndpoint: DummyEndpoint = .init(host: " ", baseUrl: " dummy")
        let dummyURLResponse: URLResponse = .init()
        let dummyData: Data = try JSONEncoder().encode("")
        let dummyCacheURLResponse: CachedURLResponse = .init(response: dummyURLResponse, data: dummyData)
        
        mockCache.cachedURLResponseToBeReturned = dummyCacheURLResponse
        
        sut.request(endpoint: dummyEndpoint) { result in
            let sutResult: Result<DummyResponse, NetworkerError> = result
            XCTAssertEqual(sutResult, .failure(.unknown("URLRequest is nil")))
        }
    }
}
