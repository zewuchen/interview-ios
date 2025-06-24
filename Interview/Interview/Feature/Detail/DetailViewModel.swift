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
    var onError: ((_ error: Error) -> Void)? { get set }

    func fetchPokemonDetail()
}

class DetailViewModel: DetailViewModelProtocol {
    //MARK: ViewModel Protocol
    var coordinator: DetailCoordinatorNavigation?

    var onPokemonUpdated: ((_ modelView: PokemonDetailViewModel) -> Void)?
    var onError: ((_ error: Error) -> Void)?

    // MARK: Dependencies
    private let pokemonService: PokemonServiceProtocol
    var url: URL
    
    init(pokemonService: PokemonServiceProtocol, url: URL) {
        self.pokemonService = pokemonService
        self.url = url
    }
    
    func fetchPokemonDetail() {
        pokemonService.fetchPokemonDetails(from: url) { result in
            switch result {
            case .success(let pokemon):
                self.handleSuccess(with: pokemon)
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    func handleSuccess(with pokemon: Pokemon) {
        guard let image = self.getPokemonImage(id: pokemon.id ?? 0) else {
            onError?(NSError(domain: "PokemonError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Falha ao carregar imagem do Pokémon"]))
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
