//
//  HTTPMethodTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class HTTPMethodTests: XCTestCase {
    func test_get_shouldReturnGetRawValue() throws {
        XCTAssertEqual(HTTPMethod.GET.rawValue, "get")
    }
}
