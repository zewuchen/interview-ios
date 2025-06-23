//
//  PokemonRowBackgroundUseCaseTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import XCTest
@testable import Interview

final class PokemonRowBackgroundUseCaseTests: XCTestCase {
    let dummyIndex: Int = 0
    private let mathHelperSpy: MathHelperSpy = .init()
    private lazy var sut: PokemonRowBackgroundUseCase = .init(mathHelper: mathHelperSpy)
    
    //    Se seu Index for impar, o seu background deverá ser blue.
    func test_getRowBackground_whenIndexIsOdd_shouldReturnSystemBlue() {
        mathHelperSpy.isNumberEvenToBeReturned = false
        
        XCTAssertEqual(sut.getRowBackground(index: dummyIndex), .systemBlue)
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.first, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.count, 0)
    }
    
    //    Se seu Index for par e multiplo de 10, o seu background deverá ser red
    func test_getRowBackground_whenIndexIsEven_whenIndexIsMultipleOf_shouldReturnSystemRed() {
        mathHelperSpy.isNumberEvenToBeReturned = true
        mathHelperSpy.isNumberMultipleOfToBeReturned = true
        
        XCTAssertEqual(sut.getRowBackground(index: dummyIndex), .systemRed)
        verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected()
    }
    
    //    Se seu Index for par e não é multiplo de 10, o seu background deverá ser yellow
    func test_getRowBackground_whenIndexIsEven_whenIndexIsNotMultipleOf_shouldReturnSystemRed() {
        mathHelperSpy.isNumberEvenToBeReturned = true
        mathHelperSpy.isNumberMultipleOfToBeReturned = false
        
        XCTAssertEqual(sut.getRowBackground(index: dummyIndex), .systemYellow)
        verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected()
    }
    
    private func verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected() {
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.count, 1)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.count, 1)
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.first, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.first?.number, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.first?.multiple, 10)
    }
}
