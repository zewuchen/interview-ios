//
//  MainViewModel.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    var coordinator: DetailCoordinatorNavigation? { get set }
    var onPokemonUpdated: ((_ modelView: PokemonDetailViewModel) -> Void)? { get set }
    
    func fetchPokemonDetail()
}

class DetailViewModel: DetailViewModelProtocol {
    //MARK: ViewModel Protocol
    var coordinator: DetailCoordinatorNavigation?
    var onPokemonUpdated: ((_ modelView: PokemonDetailViewModel) -> Void)?

    // MARK: Dependencies
    private let pokemonService: PokemonService
    
    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemonDetail() {
        guard let image = UIImage(named: "bulbasaur") else {
            return
        }
        self.onPokemonUpdated?(PokemonDetailViewModel(name: "Bulbasaur", number: "1", height: "7", weight: "69", image: image))
    }
}
