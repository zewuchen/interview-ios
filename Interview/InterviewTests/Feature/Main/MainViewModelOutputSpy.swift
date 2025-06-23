//
//  MainViewModelOutputSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
@testable import Interview

final class MainViewModelOutputSpy: MainViewModelOutput {
    
    private(set) var willLoadPokemonsVerifier: [String] = []
    private(set) var loadedPokemonsWithSuccessVerifier: Int = 0
    private(set) var loadedPokemonsWithFailureVerifier: [String] = []
    
    func willLoadPokemons(message: String) {
        willLoadPokemonsVerifier.append(message)
    }
    
    func loadedPokemonsWithSuccess() {
        loadedPokemonsWithSuccessVerifier += 1
    }
    
    func loadedPokemonsWithFailure(message: String) {
        loadedPokemonsWithFailureVerifier.append(message)
    }
}
