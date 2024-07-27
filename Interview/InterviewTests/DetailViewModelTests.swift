//
//  DetailViewModelTests.swift
//  InterviewTests
//
//  Created by Caio Cesar de Oliveira on 26/07/24.
//

import XCTest
@testable import Interview

class DetailViewModelTests: XCTestCase {
    
    // Mock Service
    class MockService: Service {
        var shouldReturnError = false
        var pokemonDetailResponse: PokemonDetailResponseModel?
        
        func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailResponseModel, Error>) -> Void) {
            if shouldReturnError {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            } else if let response = pokemonDetailResponse {
                completion(.success(response))
            }
        }
    }
    
    // Mock Delegate
    class MockDetailViewModelDelegate: DetailViewModelDelegate {
        var fetchSuccessCalled = false
        var fetchFailureCalled = false
        var fetchedModel: PokemonDetailModel?
        var fetchedError: Error?
        
        func fetchPokemonDataSuccess(model: PokemonDetailModel) {
            fetchSuccessCalled = true
            fetchedModel = model
        }
        
        func fetchPokemonDataFailure(error: Error) {
            fetchFailureCalled = true
            fetchedError = error
        }
    }
    
    var viewModel: DetailViewModel!
    var mockService: MockService!
    var mockDelegate: MockDetailViewModelDelegate!
    
    override func setUpWithError() throws {
        mockService = MockService()
        mockDelegate = MockDetailViewModelDelegate()
        viewModel = DetailViewModel(service: mockService, url: "https://example.com")
        viewModel.viewDelegate = mockDelegate
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        mockDelegate = nil
    }
    
    func testFetchPokemonDataSuccess() throws {
        // Setup
        let responseModel = PokemonDetailResponseModel(name: "Pikachu", id: 25, height: 4, weight: 60)
        mockService.pokemonDetailResponse = responseModel
        
        // Act
        viewModel.fetchPokemonData()
        
        // Assert
        XCTAssertTrue(mockDelegate.fetchSuccessCalled, "Delegate should be notified of success")
        XCTAssertFalse(mockDelegate.fetchFailureCalled, "Delegate should not be notified of failure")
        XCTAssertEqual(mockDelegate.fetchedModel?.name, "Nome: Pikachu", "The model name should be properly formatted")
        XCTAssertEqual(mockDelegate.fetchedModel?.image, PokemonsImage.bulbasaur.rawValue, "The image should be Bulbasaur")
    }
    
    func testFetchPokemonDataFailure() throws {
        // Setup
        mockService.shouldReturnError = true
        
        // Act
        viewModel.fetchPokemonData()
        
        // Assert
        XCTAssertFalse(mockDelegate.fetchSuccessCalled, "Delegate should not be notified of success")
        XCTAssertTrue(mockDelegate.fetchFailureCalled, "Delegate should be notified of failure")
        XCTAssertNotNil(mockDelegate.fetchedError, "Error should be passed to the delegate")
    }
    
    func testPrepareImage() throws {
        XCTAssertEqual(viewModel.prepareImage(5), PokemonsImage.charmander.rawValue, "The image should be Charmander")
        XCTAssertEqual(viewModel.prepareImage(2), PokemonsImage.squirtle.rawValue, "The image should be Squirtle")
        XCTAssertEqual(viewModel.prepareImage(3), PokemonsImage.bulbasaur.rawValue, "The image should be Bulbasaur")
    }
}
