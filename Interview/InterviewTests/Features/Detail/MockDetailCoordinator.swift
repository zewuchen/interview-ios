//
//  MockDetailCoordinator.swift
//  InterviewTests
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import UIKit
@testable import Interview

class MockDetailCoordinator: DetailCoordinatorNavigation {
    var onFinishCalled = false
    
    func onFinish() {
        onFinishCalled = true
    }
    
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController = UINavigationController()
    func start() {}
}
