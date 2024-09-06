//
//  PokemonRowBackgroundUseCase.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import UIKit

protocol PokemonRowBackgroundUseCaseProtocol {
    func getRowBackground(index: Int) -> UIColor
}

final class PokemonRowBackgroundUseCase: PokemonRowBackgroundUseCaseProtocol {
    private let mathHelper: MathHelperProtocool
    
    init(mathHelper: MathHelperProtocool) {
        self.mathHelper = mathHelper
    }
    
    func getRowBackground(index: Int) -> UIColor {
        guard mathHelper.isNumberEven(index) else {
            return .systemBlue
        }
        
        guard mathHelper.isNumberMultipleOf(index, multiple: 10) else {
            return .systemYellow
        }
        
        return .systemRed
    }
}
