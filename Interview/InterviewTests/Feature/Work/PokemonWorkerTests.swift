//
//  PokemonWorkerTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class CharactersWorkerTests: XCTestCase {

    private let networkerSpy: NetworkerSpy<PokemonCatalogResponse> = .init()
    private let environmentStub: EnvironmentStub.Type = EnvironmentStub.self
    private lazy var sut: PokemonWorker = PokemonWorker(
        serviceProxy: networkerSpy,
        environment: environmentStub
    )

    func test_fetchCharacters_whenSuccess_shouldCallRequest() throws {
        networkerSpy.resultToBeReturned = .success(
            PokemonCatalogResponse(
                count: 1,
                results: [.init(name: "dummyName", url: "dummyUrl")]
            )
        )
        
        sut.fetchPokemons { result in
            XCTAssertEqual(
                result,
                .success(
                    PokemonCatalogResponse(
                        count: 1,
                        results: [.init(name: "dummyName", url: "dummyUrl")]
                    )
                )
            )
        }
        
        networkerSpy.verifyArgumentsToRequest(
            endpoint: DummyEndpoint(
                host: "pokeapi.co",
                baseUrl: "/api/v2/pokemon/",
                method: .GET
            )
        )
    }
    
    func test_f1etchCharacters_whenSuccess_shouldCallRequest() throws {
        networkerSpy.resultToBeReturned = .failure(.badRequest)
        
        sut.fetchPokemons { result in
            XCTAssertEqual(result, .failure(.badRequest))
        }
        
        networkerSpy.verifyArgumentsToRequest(
            endpoint: DummyEndpoint(
                host: "pokeapi.co",
                baseUrl: "/api/v2/pokemon/",
                method: .GET
            )
        )
    }
}
