//
//  PokemonRowRuleUseCaseSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit
@testable import Interview

final class PokemonRowRuleUseCaseSpy: PokemonRowRuleUseCaseProtocol {
    
    private(set) var getRowBackgroundVerifier: [Int] = []
    
    var getRowBackgroundToBeReturned: UIColor = .clear
    
    func getRowBackground(index: Int) -> UIColor {
        getRowBackgroundVerifier.append(index)
        return getRowBackgroundToBeReturned
    }
}
