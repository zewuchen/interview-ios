//
//  ServiceProxyTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 07/09/24.
//

import XCTest
@testable import Interview

final class ServiceProxyTests: XCTestCase {
    let dummyCachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private let networkerSpy: NetworkerSpy<DummyResponse> = .init()
    private let cacheworkerSpy: CacheworkerSpy<DummyResponse> = .init()
    private lazy var sut: ServiceProxy = .init(
        networker: networkerSpy,
        cacheWorker: cacheworkerSpy
    )
    
    func test_request_whenCacheworkWithSuccess_shouldNotCallNetwork_and_shouldGetResponseFromCache() throws {
        let dummyResponse: DummyResponse = DummyResponse(dummy: "dummy_from_cache")
        let dummyEndpoint: DummyEndpoint = .init()
        cacheworkerSpy.resultToBeReturned = .success(dummyResponse)
        let expect = expectation(description: "load from cache")
        
        sut.request(endpoint: dummyEndpoint, cachePolicy: dummyCachePolicy) { result in
            switch result as Result<DummyResponse, NetworkerError> {
            case .success(let response):
                XCTAssertEqual(response, dummyResponse)
            case .failure(let failure):
                XCTFail("not expected a failure \(failure)")
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
        
        XCTAssertEqual(cacheworkerSpy.requestVerifier.count, 1)
        XCTAssertEqual(networkerSpy.requestVerifier.isEmpty, true)
        cacheworkerSpy.verifyArgumentsToRequest(endpoint: dummyEndpoint)
    }
    
    func test_request_whenCacheworkWithFailure_whenNetworkSuccess_shouldCallNetwork_and_shouldGetResponseFromNetwork() throws {
        let dummyResponse: DummyResponse = DummyResponse(dummy: "dummy_from_network")
        let dummyEndpoint: DummyEndpoint = .init()
        cacheworkerSpy.resultToBeReturned = .failure(.parseError)
        networkerSpy.resultToBeReturned = .success(dummyResponse)
        let expect = expectation(description: "load from network")
        
        sut.request(endpoint: dummyEndpoint, cachePolicy: dummyCachePolicy) { result in
            switch result as Result<DummyResponse, NetworkerError> {
            case .success(let response):
                XCTAssertEqual(response, dummyResponse)
            case .failure(let failure):
                XCTFail("not expected a failure \(failure)")
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
        
        XCTAssertEqual(cacheworkerSpy.requestVerifier.count, 1)
        XCTAssertEqual(networkerSpy.requestVerifier.count, 1)
        cacheworkerSpy.verifyArgumentsToRequest(endpoint: dummyEndpoint)
        networkerSpy.verifyArgumentsToRequest(endpoint: dummyEndpoint)
    }
    
    func test_request_whenCacheworkWithFailure_whenNetworkFailure_shouldCallNetwork_and_shouldGetFailureFromNetwork() throws {
        let dummyResponse: DummyResponse = DummyResponse(dummy: "dummy_from_network")
        let dummyEndpoint: DummyEndpoint = .init()
        cacheworkerSpy.resultToBeReturned = .failure(.parseError)
        networkerSpy.resultToBeReturned = .failure(.unknown("error from network"))
        let expect = expectation(description: "load from cache")
        
        sut.request(endpoint: dummyEndpoint, cachePolicy: dummyCachePolicy) { result in
            switch result as Result<DummyResponse, NetworkerError> {
            case .success(let response):
                XCTAssertEqual(response, dummyResponse)
            case .failure(let failure):
                XCTAssertEqual(failure, .unknown("error from network"))
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
        
        XCTAssertEqual(cacheworkerSpy.requestVerifier.count, 1)
        XCTAssertEqual(networkerSpy.requestVerifier.count, 1)
        cacheworkerSpy.verifyArgumentsToRequest(endpoint: dummyEndpoint)
        networkerSpy.verifyArgumentsToRequest(endpoint: dummyEndpoint)
    }
}
