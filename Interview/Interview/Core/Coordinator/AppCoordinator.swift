//
//  AppCoordinator.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let child = MainCoordinator(presenter: presenter)
        child.parentCoordinator = self
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
