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
            URLRequestFactory.make(
                from: dummyEndpoint,
                cachePolicy: .returnCacheDataElseLoad
            ),
            URLRequest(
                url: try XCTUnwrap(URL(string: "https://dummy_host/dummy_baseUrl")),
                cachePolicy: .returnCacheDataElseLoad
            )
        )
    }
}
