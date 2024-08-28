//
//  DetailViewModelTests.swift
//  InterviewTests
//
//  Created by Natali Cabral on 26/08/24.
//

import XCTest
@testable import Interview

class DetailViewModelTests: XCTestCase {

    var sut: DetailViewModel!
    var mockViewControllerDelegate: MockDetailViewControllerDelegate!
    var mockWorker: MockRequest!

    override func setUp() {
        super.setUp()
        mockViewControllerDelegate = MockDetailViewControllerDelegate()
        mockWorker = MockRequest()
        sut = DetailViewModel()
        sut.viewControllerDelegate = mockViewControllerDelegate
        sut.worker = mockWorker
    }

    override func tearDown() {
        sut = nil
        mockViewControllerDelegate = nil
        mockWorker = nil
        super.tearDown()
    }

    func testGetPokemonDataSuccess() {
        // Given
        let mockPokemonDetail = PokemonDetail(id: 1, name: "Pikachu", height: 45 ,weight: 190)
        mockWorker.mockResult = .success(mockPokemonDetail)

        // When
        sut.getPokemonData(url: "https://pokeapi.co/api/v2/pokemon/1/")

        // Then
        XCTAssertEqual(sut.pokemonDetails?.id, 1)
        XCTAssertEqual(mockViewControllerDelegate.pokemonDetail?.name, "Pikachu")
        XCTAssertEqual(mockViewControllerDelegate.image, .bulbasaur) // Assumindo id 1 é bulbasaur
    }

    func testGetPokemonDataFailure() {
        // Given
        let mockError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        mockWorker.mockResult = .failure(mockError)

        // When
        sut.getPokemonData(url: "https://pokeapi.co/api/v2/pokemon/1/")

        // Then
        XCTAssertEqual(sut.error, "Failed to fetch data")
    }

    func testShowPokemonImage() {
        // Test para Bulbasaur
        XCTAssertEqual(sut.showPokemonImage(for: 1), .bulbasaur)
        
        // Test para Squirtle
        XCTAssertEqual(sut.showPokemonImage(for: 2), .squirtle)
        
        // Test para Charmander
        XCTAssertEqual(sut.showPokemonImage(for: 5), .charmander)
    }
    
    class MockRequest: Request {
        var mockResult: Result<PokemonDetail, Error>?

        override func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
            if let result = mockResult {
                completion(result)
            }
        }
    }

    class MockDetailViewControllerDelegate: DetailViewControllerDelegate {
        var pokemonDetail: PokemonDetail?
        var image: PokemonsImage?

        func setValues(pokemonDetail: PokemonDetail, image: PokemonsImage) {
            self.pokemonDetail = pokemonDetail
            self.image = image
        }
    }
    
}
