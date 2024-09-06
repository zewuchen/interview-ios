//
//  EnvironmentTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class EnvironmentTests: XCTestCase {

    private let sut: Environment.Type = Environment.self
    
    func test_host_pokeapi_shouldReturnExpectedValue() throws {
        XCTAssertEqual(sut.Host.pokeapi.host, "pokeapi.co")
    }
}
