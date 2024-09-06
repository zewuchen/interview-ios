//
//  PokemonDetailAssetRuleUseCaseSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
@testable import Interview

final class PokemonDetailAssetRuleUseCaseSpy: PokemonDetailAssetRuleUseCaseProtocol {
    private(set) var getImageAssetFromIdVerifier: [Int?] = []
    var getImageAssetFromIdToBeReturned: String = ""
    
    func getImageAssetFromId(_ id: Int?) -> String {
        getImageAssetFromIdVerifier.append(id)
        return getImageAssetFromIdToBeReturned
    }
}
