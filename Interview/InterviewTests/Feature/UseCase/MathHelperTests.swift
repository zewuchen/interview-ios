//
//  MathHelperTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class MathHelperTests: XCTestCase {
    
    private let sut: MathHelper = .init()
    
    func test_isNumberEven_whenNumberIsEven_shouldReturnTrue() {
        let dummyNumber: Int = 4
        
        XCTAssertEqual(sut.isNumberEven(dummyNumber), true)
    }
    
    func test_isNumberEven_whenNumberIsOdd_shouldReturnFalse() {
        let dummyNumber: Int = 3
        
        XCTAssertEqual(sut.isNumberEven(dummyNumber), false)
    }
    
    func test_isNumberMultipleOf_whenNumberIsMultipleOf_shouldReturnTrue() {
        let dummyMultiple: Int = 5
        let dummyNumber: Int = 10
        
        XCTAssertEqual(sut.isNumberMultipleOf(dummyNumber, multiple: dummyMultiple), true)
    }
    
    func test_isNumberMultipleOf_whenNumberIsNotMultipleOf_shouldReturnTrue() {
        let dummyMultiple: Int = 5
        let dummyNumber: Int = 13
        
        XCTAssertEqual(sut.isNumberMultipleOf(dummyNumber, multiple: dummyMultiple), false)
    }
}
