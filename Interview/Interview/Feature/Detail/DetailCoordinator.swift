//
//  MainCoordinator.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import UIKit

protocol DetailCoordinatorNavigation: Coordinator {
    func onFinish()
}

final class DetailCoordinator: DetailCoordinatorNavigation {
    
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    var url: URL

    init(presenter: UINavigationController, url: URL) {
        self.presenter = presenter
        self.url = url
    }
    
    func start() {
        let pokemonService = PokeApi()
        let viewModel = DetailViewModel(pokemonService: pokemonService, url: url)
        let viewController = DetailViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func onFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
