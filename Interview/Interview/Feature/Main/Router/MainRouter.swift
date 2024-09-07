//
//  MainRouter.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import UIKit

final class MainRouter {
    func start(from navigation: UINavigationController) {
        let mathHelper: MathHelperProtocool = MathHelper()
        let pokemonRowBackgroundColorUserCase: PokemonRowBackgroundUseCase = .init(mathHelper: mathHelper)
        
        let mainViewModel: MainViewModelProtocol = MainViewModel(
            pokemonWorker: PokemonWorkerFactory.make(),
            pokemonRowBackgroundColorUserCase: pokemonRowBackgroundColorUserCase
        )
        
        let controller = MainViewController(viewModel: mainViewModel)
        
        navigation.pushViewController(controller, animated: true)
    }
}
