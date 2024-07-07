//
//  InterviewTests.swift
//  InterviewTests
//
//  Created by Zewu Chen on 28/06/24.
//

import XCTest
@testable import Interview

final class InterviewTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testCorDoBackgroundDaListaDePokemons() {
        let mainViewModel = MainViewModel()
        let valorPar = 2
        let valorParMultiploDeDez = 10
        let valorImpar = 1
        
        XCTAssertEqual(mainViewModel.checkBackground(valorPar), .yellow)
        XCTAssertEqual(mainViewModel.checkBackground(valorParMultiploDeDez), .red)
        XCTAssertEqual(mainViewModel.checkBackground(valorImpar), .blue)

    }

    func testImagemDePokemonMostrada() {
        let mainViewModel = DetailViewModel()
        let valorPar = 2
        let valorParMultiploDeCinco = 5
        let valorImpar = 1
        
        XCTAssertEqual(mainViewModel.showPokemonImage(valorPar), .squirtle)
        XCTAssertEqual(mainViewModel.showPokemonImage(valorParMultiploDeCinco), .charmander)
        XCTAssertEqual(mainViewModel.showPokemonImage(valorImpar), .bulbasaur)
    }
}
