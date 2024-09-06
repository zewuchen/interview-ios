//
//  PokemonRowBackgroundColorUseCaseSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import UIKit
@testable import Interview

final class PokemonRowBackgroundColorUseCaseSpy: PokemonRowBackgroundUseCaseProtocol {
    var getRowBackgroundToBeReturned: UIColor = .clear
    private(set) var getRowBackgroundVerifier: [Int] = []
    
    func getRowBackground(index: Int) -> UIColor {
        getRowBackgroundVerifier.append(index)
        return getRowBackgroundToBeReturned
    }
}
