//
//  DetailRouter.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

final class DetailRouter {
    func start(from navigation: UINavigationController?, with url: URL) {
        let mathHelper: MathHelper = .init()
        let pokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCase = PokemonDetailAssetRuleUseCase(
            mathHelper: mathHelper
        )
        let viewModel: DetailViewModel = .init(
            pokemonDetailWorker: PokemonWorkerFactory.make(),
            url: url,
            pokemonDetailAssetRuleUseCase: pokemonDetailAssetRuleUseCase
        )
        
        let controller: DetailViewController = .init(viewModel: viewModel)
        
        navigation?.pushViewController(controller, animated: true)
    }
}
