//
//  DetailViewModelTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import XCTest
@testable import Interview

final class DetailViewModelTests: XCTestCase {

    private let dummyURL: URL = .init(string: "www.dummy.com")!
    private let detailViewModelOutputSpy: DetailViewModelOutputSpy = .init()
    private var pokemonDetailAssetRuleUseCaseSpy: PokemonDetailAssetRuleUseCaseSpy = .init()
    private var pokemonDetailWorker: PokemonWorkerSpy = .init()
    private lazy var sut: DetailViewModel = .init(
        pokemonDetailWorker: pokemonDetailWorker,
        url: dummyURL,
        pokemonDetailAssetRuleUseCase: pokemonDetailAssetRuleUseCaseSpy
    )
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut.setDelegate(detailViewModelOutputSpy)
    }

    func test_fetchDetail_shouldCallWillLoadPokemonInfo() throws {
        sut.fetchDetail()
     
        XCTAssertEqual(detailViewModelOutputSpy.willLoadPokemonInfoVerifier.count, 1)
    }
    
    func test_fetchDetail_whenFailure_shouldCallLoadedPokemonInfoFailure() throws {
        pokemonDetailWorker.resultFetchPokemonDetailToBeReturned = .failure(.badRequest)
        
        sut.fetchDetail()
     
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonsInfoFailureVerifier.count, 1)
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonsInfoFailureVerifier.first, "Erro ao carregar informações.")
    }
    
    func test_fetchDetail_whenSuccess_shouldCallLoadedPokemonInfoSuccess() throws {
        pokemonDetailAssetRuleUseCaseSpy.getImageAssetFromIdToBeReturned = "dummyAsset"
        let dummyPokemonDetailResponse: PokemonDetailResponse = .init(
            id: 123,
            height: 2,
            name: "dummyName",
            weight: 3
        )
        pokemonDetailWorker.resultFetchPokemonDetailToBeReturned = .success(dummyPokemonDetailResponse)
        
        sut.fetchDetail()
     
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.count, 1)
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.first?.height, "Altura: 2")
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.first?.id, "Número: 123")
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.first?.imageAsset, "dummyAsset")
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.first?.name, "Nome: Dummyname")
        XCTAssertEqual(detailViewModelOutputSpy.loadedPokemonInfoWithSuccessVerifier.first?.weigh, "Peso: 3")
        XCTAssertEqual(pokemonDetailAssetRuleUseCaseSpy.getImageAssetFromIdVerifier.count, 1)
        XCTAssertEqual(pokemonDetailAssetRuleUseCaseSpy.getImageAssetFromIdVerifier.first, 123)
    }
}
