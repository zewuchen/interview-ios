//
//  PokemonRowRuleUseCase.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol PokemonRowRuleUseCaseProtocol {
    func isIndexEven(_ index: Int) -> Bool
    func isIndexMultipleOf10(_ index: Int) -> Bool
}

final class PokemonRowRuleUseCase: PokemonRowRuleUseCaseProtocol {
    func isIndexEven(_ index: Int) -> Bool {
        return index % 2 == 0
    }
    
    func isIndexMultipleOf10(_ index: Int) -> Bool {
        return index % 10 == 0
    }
}
