//
//  MainCoordinator.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}

protocol MainCoordinatorProtocol: Coordinator, AnyObject {
    func showDetail(url: URL)
}

final class MainCoordinator: MainCoordinatorProtocol {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let mathHelper: MathHelperProtocool = MathHelper()
        let pokemonRowBackgroundColorUserCase: PokemonRowBackgroundUseCase = .init(mathHelper: mathHelper)
        
        let mainViewModel: MainViewModelProtocol = MainViewModel(
            pokemonWorker: PokemonWorkerFactory.make(),
            pokemonRowBackgroundColorUserCase: pokemonRowBackgroundColorUserCase
        )
        
        let controller = MainViewController(viewModel: mainViewModel)
        controller.coordinator = self
        navigation.pushViewController(controller, animated: true)
    }
    
    func showDetail(url: URL) {
        let mathHelper: MathHelper = .init()
        let viewModel: DetailViewModel = .init(
            pokemonDetailWorker: PokemonWorkerFactory.make(),
            url: url,
            pokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCase(mathHelper: mathHelper)
        )
        
        let detailController: DetailViewController = .init(viewModel: viewModel)
        navigation.pushViewController(detailController, animated: true)
    }
}
