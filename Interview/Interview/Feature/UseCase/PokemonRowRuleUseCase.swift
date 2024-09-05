//
//  PokemonRowRuleUseCase.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

protocol PokemonRowRuleUseCaseProtocol {
    func getRowBackground(index: Int) -> UIColor
}

final class PokemonRowRuleUseCase: PokemonRowRuleUseCaseProtocol {
    func getRowBackground(index: Int) -> UIColor {
        guard isIndexEven(index) else {
            return .systemBlue
        }
        
        guard isIndexMultipleOf10(index) else {
            return .systemYellow
        }
        
        return .systemRed
    }
    
    private func isIndexEven(_ index: Int) -> Bool {
        return index % 2 == 0
    }
    
    private func isIndexMultipleOf10(_ index: Int) -> Bool {
        return index % 10 == 0
    }
}
