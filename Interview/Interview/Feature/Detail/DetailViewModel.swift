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
    var url: URL

    // MARK: Dependencies
    private let pokemonService: PokemonService
    
    init(pokemonService: PokemonService, url: URL) {
        self.pokemonService = pokemonService
        self.url = url
    }
    
    func fetchPokemonDetail() {
        pokemonService.fetchPokemonDetails(from: url) { result in
            switch result {
            case .success(let pokemon):
                self.handleSuccess(with: pokemon)
            case .failure: break
            }
        }
    }
    
    func handleSuccess(with pokemon: Pokemon) {
        guard let image = self.getPokemonImage(id: pokemon.id ?? 0) else {
            return
        }
        let model = PokemonDetailViewModel(
            name: pokemon.name.capitalized,
            number: "\(pokemon.id ?? 0)",
            height: "\(pokemon.height ?? 0)",
            weight: "\(pokemon.weight ?? 0)",
            image: image
        )

        self.onPokemonUpdated?(model)
    }
}

private extension DetailViewModel {
    func getPokemonImage(id: Int) -> UIImage? {
        let imageName: String
        if id % 2 != 0 {
            imageName = id % 5 == 0 ? "charmander" : "bulbasaur"
        } else {
            imageName = "squirtle"
        }
        
        return UIImage(named: imageName)
    }
}
