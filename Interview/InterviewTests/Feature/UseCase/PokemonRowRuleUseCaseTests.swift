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
    
    func test_getRowBackground_whenIsOdd_shouldReturnFalse() throws {
        XCTAssertEqual(sut.getRowBackground(index: 3), .systemBlue)
    }
    
    func test_getRowBackground_whenIsEven_and_whenIsMultiple10_shouldReturnTrue() throws {
        XCTAssertEqual(sut.getRowBackground(index: 10), .systemRed)
    }
    
    func test_getRowBackground_whenIsEven_and_whenIsNotMultiple10_shouldReturnFalse() throws {
        XCTAssertEqual(sut.getRowBackground(index: 14), .systemYellow)
    }
}
