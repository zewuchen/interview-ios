//
//  MockMainCoordinator.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import XCTest
@testable import Interview

class MockMainCoordinator: MainCoordinatorNavigation {
    var showPokemonDetailsCalled = false
    var url: URL?
    
    func showPokemonDetails(with url: URL) {
        showPokemonDetailsCalled = true
        self.url = url
    }
    
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController = UINavigationController()
    func start() {}
}
