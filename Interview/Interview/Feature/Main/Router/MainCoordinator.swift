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
    private let pokemonWorker: PokemonWorkerProtocol
    private let mathHelper: MathHelperProtocool = MathHelper()
    
    init(navigation: UINavigationController, pokemonWorker: PokemonWorkerProtocol) {
        self.navigation = navigation
        self.pokemonWorker = pokemonWorker
    }
    
    func start() {
        let pokemonRowBackgroundColorUserCase: PokemonRowBackgroundUseCase = .init(mathHelper: mathHelper)
        
        let mainViewModel: MainViewModelProtocol = MainViewModel(
            pokemonWorker: pokemonWorker,
            pokemonRowBackgroundColorUserCase: pokemonRowBackgroundColorUserCase
        )
        
        let controller = MainViewController(viewModel: mainViewModel)
        controller.coordinator = self
        navigation.pushViewController(controller, animated: true)
    }
    
    func showDetail(url: URL) {
        let viewModel: DetailViewModel = .init(
            pokemonDetailWorker: pokemonWorker,
            url: url,
            pokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCase(mathHelper: mathHelper)
        )
        
        let detailController: DetailViewController = .init(viewModel: viewModel)
        navigation.pushViewController(detailController, animated: true)
    }
}
