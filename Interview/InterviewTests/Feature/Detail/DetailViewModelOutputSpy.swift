//
//  DetailViewModelOutputSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
@testable import Interview

final class DetailViewModelOutputSpy: DetailViewModelOutput {
    private(set) var willLoadPokemonInfoVerifier: [String] = []
    private(set) var loadedPokemonInfoWithSuccessVerifier: [PokemonDetailRow] = []
    private(set) var loadedPokemonsInfoFailureVerifier: [String] = []
    
    func willLoadPokemonInfo(message: String) {
        willLoadPokemonInfoVerifier.append(message)
    }
    
    func loadedPokemonInfoWithSuccess(detail: PokemonDetailRow) {
        loadedPokemonInfoWithSuccessVerifier.append(detail)
    }
    
    func loadedPokemonsInfoFailure(message: String) {
        loadedPokemonsInfoFailureVerifier.append(message)
    }
}
