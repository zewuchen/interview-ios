//
//  MainCoordinator.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import UIKit

protocol MainCoordinatorNavigation: Coordinator {
    func showPokemonDetails(with url: URL)
}

final class MainCoordinator: MainCoordinatorNavigation {
    
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let pokemonService = PokeApi()
        let viewModel = MainViewModel(pokemonService: pokemonService)
        let viewController = MainViewController(viewModel: viewModel)
        viewController.viewModel.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
    
    func showPokemonDetails(with url: URL) {
        let coordinator = DetailCoordinator(presenter: presenter)
        coordinator.start()
    }
}
