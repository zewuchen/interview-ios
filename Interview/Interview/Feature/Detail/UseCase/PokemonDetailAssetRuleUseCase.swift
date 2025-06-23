//
//  PokemonDetailAssetRuleUseCase.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation

protocol PokemonDetailAssetRuleUseCaseProtocol {
    func getImageAssetFromId(_ id: Int?) -> String
}

final class PokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCaseProtocol {
    private let multiply: Int = 5
    private let mathHelper: MathHelperProtocool
    
    init(mathHelper: MathHelperProtocool) {
        self.mathHelper = mathHelper
    }
    
    func getImageAssetFromId(_ id: Int?) -> String {
        guard let id else { return "placeholder" }
        
        guard !mathHelper.isNumberEven(id) else {
            return "squirtle"
        }
        
        guard !mathHelper.isNumberMultipleOf(id, multiple: multiply) else {
            return "charmander"
        }
        
        return "bulbasaur"
    }
}
