//
//  PokemonWorkerTests.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import XCTest
@testable import Interview

final class CharactersWorkerTests: XCTestCase {
    
    private func givemSut(serviceProxySpy: ServiceProxyProtocol) -> PokemonWorker {
        let environmentStub: EnvironmentStub.Type = EnvironmentStub.self
        return PokemonWorker(
            serviceProxy: serviceProxySpy,
            environment: environmentStub
        )
    }
    
    func test_fetchCharacters_whenSuccess_shouldCallRequest() throws {
        let serviceProxySpy: ServiceProxySpy<PokemonCatalogResponse> = .init()
        let sut: PokemonWorker = givemSut(serviceProxySpy: serviceProxySpy)
        serviceProxySpy.resultToBeReturned = .success(
            PokemonCatalogResponse(
                count: 1, results: [
                    .init(name: "dummyName", url: "dummyUrl")
                ]
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
        
        serviceProxySpy.verifyArgumentsToRequest(
            endpoint: DummyEndpoint(
                host: "pokeapi.co",
                baseUrl: "/api/v2/pokemon/",
                method: .GET
            )
        )
    }
    
    func test_fetchCharacters_whenFailure_shouldCallRequest() throws {
        let serviceProxySpy: ServiceProxySpy<PokemonCatalogResponse> = .init()
        let sut: PokemonWorker = givemSut(serviceProxySpy: serviceProxySpy)
        serviceProxySpy.resultToBeReturned = .failure(.badRequest)
        
        sut.fetchPokemons { result in
            XCTAssertEqual(result, .failure(.badRequest))
        }
        
        serviceProxySpy.verifyArgumentsToRequest(
            endpoint: DummyEndpoint(
                host: "pokeapi.co",
                baseUrl: "/api/v2/pokemon/",
                method: .GET
            )
        )
    }
    
    func test_fetchPokemonDetail_whenSuccess_shouldCallRequest() throws {
        let serviceProxySpy: ServiceProxySpy<PokemonDetailResponse> = .init()
        let sut: PokemonWorker = givemSut(serviceProxySpy: serviceProxySpy)
        let dummyURL: URL = try XCTUnwrap(URL(string: "https://www.dummy.com/dummyPath"))
        serviceProxySpy.resultToBeReturned = .success(
            PokemonDetailResponse(id: 1, height: 2, name: "dummyName", weight: 3)
        )
        
        sut.fetchPokemonDetail(url: dummyURL) { result in
            XCTAssertEqual(
                result,
                .success(
                    PokemonDetailResponse(id: 1, height: 2, name: "dummyName", weight: 3)
                )
            )
        }
        
        serviceProxySpy.verifyArgumentsToRequest(
            endpoint: DummyEndpoint(
                host: "www.dummy.com",
                baseUrl: "/dummyPath",
                method: .GET
            )
        )
    }
    
    func test_fetchPokemonDetail_whenFailure_shouldCallRequest() throws {
        let dummyURL: URL = try XCTUnwrap(URL(string: "https://www.dummy.com/dummyPath"))
        let serviceProxySpy: ServiceProxySpy<PokemonDetailResponse> = .init()
        let sut: PokemonWorker = givemSut(serviceProxySpy: serviceProxySpy)
        serviceProxySpy.resultToBeReturned = .failure(.badRequest)
        
        sut.fetchPokemonDetail(url: dummyURL) { result in
            XCTAssertEqual(result, .failure(.badRequest))
        }
    }
    
    func test_fetchPokemonDetail_whenURLNil_shouldGetFailure() throws {
        let dummyURL: URL = try XCTUnwrap(URL(string: " "))
        let serviceProxySpy: ServiceProxySpy<PokemonDetailResponse> = .init()
        let sut: PokemonWorker = givemSut(serviceProxySpy: serviceProxySpy)
        serviceProxySpy.resultToBeReturned = .failure(.badRequest)
        
        sut.fetchPokemonDetail(url: dummyURL) { result in
            XCTAssertEqual(result, .failure(.parseError))
        }
    }
}
