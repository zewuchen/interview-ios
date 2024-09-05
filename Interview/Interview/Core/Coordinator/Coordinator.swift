//
//  Coordinator.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var presenter: UINavigationController { get set }
    
    func start()
}
