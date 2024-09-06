//
//  ConstantsTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import XCTest
@testable import Interview

final class ConstantsTests: XCTestCase {
    
    func test_space_medium_shouldReturnExpectedValue() throws {
        XCTAssertEqual(Constants.Space.medium, 8)
    }
    
    func test_strings_shouldReturnExpectedValue() throws {
        XCTAssertEqual(Constants.Strings.errorLoading, "Erro ao carregar informações.")
        XCTAssertEqual(Constants.Strings.loading, "Carregando")
        XCTAssertEqual(Constants.Strings.pokemons, "Pokemons")
    }
}
