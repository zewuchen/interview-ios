//
//  PokemonRowRuleUseCaseTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class PokemonRowRuleUseCaseTests: XCTestCase {

    private let sut: PokemonRowRuleUseCase = .init()
    
    func test_isIndexEven_whenIsOdd_shouldReturnFalse() throws {
        XCTAssertEqual(sut.isIndexEven(3), false)
    }
    
    func test_isIndexEven_whenIsEvent_shouldReturnTrue() throws {
        XCTAssertEqual(sut.isIndexEven(4), true)
    }
    
    func test_isIndexMultipleOf10_whenIsMultipleOf10_shouldReturnTrue() throws {
        XCTAssertEqual(sut.isIndexMultipleOf10(50), true)
    }
    
    func test_isIndexMultipleOf10_whenIsNotMultipleOf10_shouldReturnTrue() throws {
        XCTAssertEqual(sut.isIndexMultipleOf10(37), false)
    }
}
