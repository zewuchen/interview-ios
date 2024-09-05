//
//  MainFactory.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation
import UIKit

struct MainFactory {
    static func make() -> UIViewController {
        let service = APIService()
        let pokemonAPI = PokeApi(serviceManager: service)
        let viewModel = MainViewModel(pokemonService: pokemonAPI)
        
        let viewController = MainViewController(viewModel: viewModel)
        
        return viewController
    }
}
