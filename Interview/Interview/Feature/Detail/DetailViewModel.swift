//
//  DetailViewModel.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func getPokemonData(url: String)
    var viewControllerDelegate: DetailViewControllerDelegate? { get set }
}

class DetailViewModel: DetailViewModelDelegate {

    var pokemonDetails: PokemonDetail?
    var error: String?
    let worker = Service()
    weak var viewControllerDelegate: DetailViewControllerDelegate?

    func getPokemonData(url: String) {
        worker.getPokemonDetail(url: url) { [self] result in
            switch result {
            case .success(let data):
                self.pokemonDetails = data
                self.viewControllerDelegate?.setValues(pokemonDetail: data, image: self.showPokemonImage(data.id))
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }

    private func showPokemonImage(_ id: Int) -> PokemonsImage {
        switch id {
        case let id where id % 2 == 1 && id % 5 == 0:
            return .charmander
        case let id where id % 2 == 0:
            return .squirtle
        default:
            return .bulbasaur
        }
    }

}
