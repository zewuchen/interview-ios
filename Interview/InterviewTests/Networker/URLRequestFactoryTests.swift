//
//  URLRequestFactoryTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 07/09/24.
//

import XCTest
@testable import Interview

final class URLRequestFactoryTests: XCTestCase {

    func test_make_shouldReturnExpectedValue() throws {
        let dummyEndpoint: DummyEndpoint = .init()
        XCTAssertEqual(
            URLRequestFactory.make(from: dummyEndpoint),
            URLRequest(
                url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")),
                cachePolicy: .returnCacheDataElseLoad
            )
        )
    }
    
    func test_make_whenInvalidUrl_shouldReturnNil() throws {
        let dummyEndpoint: DummyEndpoint = .init(host: " ", baseUrl: " invalid")
        XCTAssertEqual(
            URLRequestFactory.make(from: dummyEndpoint),
            nil
        )
    }
}
