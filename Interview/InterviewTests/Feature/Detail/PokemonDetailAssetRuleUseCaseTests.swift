//
//  PokemonDetailAssetRuleUseCaseTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import XCTest
@testable import Interview

final class PokemonDetailAssetRuleUseCaseTests: XCTestCase {
    
    private let dummyId: Int = 0
    private let mathHelperSpy: MathHelperSpy = .init()
    private lazy var sut: PokemonDetailAssetRuleUseCase = .init(mathHelper: mathHelperSpy)
    
    func test_getImageAssetFromId_whenIdIsNil_shouldReturnPlaceholder() throws {
        XCTAssertEqual(sut.getImageAssetFromId(nil), "placeholder")
        verifyMathHelperFunctionsWasNeverCalled()
    }
    
    //    Se o campo id for impar e não é multiplo de 5, a imagem deverá utilizar o asset bulbasaur
    func test_getImageAssetFromId_whenIdIsOdd_and_whenIdIsNotMultipleOf5_shouldReturnPlaceholder() throws {
        mathHelperSpy.isNumberEvenToBeReturned = false
        mathHelperSpy.isNumberMultipleOfToBeReturned = false
        
        XCTAssertEqual(sut.getImageAssetFromId(dummyId), "bulbasaur")
        verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected()
    }
    
    //    Se o campo id for impar e é multiplo de 5, a imagem deverá utilizar o asset charmander.
    func test_getImageAssetFromId_whenIdIsOdd_and_whenIdIstMultipleOf5_shouldReturnPlaceholder() throws {
        mathHelperSpy.isNumberEvenToBeReturned = false
        mathHelperSpy.isNumberMultipleOfToBeReturned = true
        
        XCTAssertEqual(sut.getImageAssetFromId(dummyId), "charmander")
        verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected()
    }
    
    //    Se o campo id for par e não for ímpar, a imagem deverá utilizar o asset squirtle.
    func test_getImageAssetFromId_whenIdIsEven_shouldReturnPlaceholder() throws {
        mathHelperSpy.isNumberEvenToBeReturned = true
        
        XCTAssertEqual(sut.getImageAssetFromId(dummyId), "squirtle")
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.count, 1)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.count, 0)
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.first, 0)
    }
    
    private func verifyMathHelperFunctionsWasCalledOnceAndArgumentsIsExpected() {
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.count, 1)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.count, 1)
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.first, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.first?.number, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.first?.multiple, 5)
    }
    
    private func verifyMathHelperFunctionsWasNeverCalled() {
        XCTAssertEqual(mathHelperSpy.isNumberEvenVerifier.count, 0)
        XCTAssertEqual(mathHelperSpy.isNumberMultipleOfVerifier.count, 0)
    }
}
