//
//  MainViewModel.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

protocol DetailViewModelProtocol {
    var coordinator: DetailCoordinatorNavigation? { get set }
}

class DetailViewModel: DetailViewModelProtocol {
    
    //MARK: ViewModel Protocol
    var coordinator: DetailCoordinatorNavigation?
    
    // MARK: Dependencies
    private let pokemonService: PokemonService
    
    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }
}
