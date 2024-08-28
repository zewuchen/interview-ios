//
//  DetailViewModel.swift
//  Interview
//
//  Created by Natali Cabral on 24/08/24.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func getPokemonData(url: String)
    var viewControllerDelegate: DetailViewControllerDelegate? { get set }
}

class DetailViewModel: DetailViewModelDelegate {

    var pokemonDetails: PokemonDetail?
    var error: String?
    var worker = Request()
    weak var viewControllerDelegate: DetailViewControllerDelegate?

    func getPokemonData(url: String) {
        worker.getPokemonDetail(url: url) { [self] result in
            switch result {
            case .success(let data):
                self.pokemonDetails = data
                self.viewControllerDelegate?.setValues(pokemonDetail: data, image: self.showPokemonImage(for: data.id))
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }

    public func showPokemonImage(for id: Int) -> PokemonsImage {
        switch id {
        case _ where id % 2 != 0 && id % 5 == 0:
            //Se o campo id for impar e é multiplo de 5, a imagem deverá utilizar o asset charmander.
            return .charmander
        case _ where id % 2 == 0:
            //Se o campo id for par e não for ímpar, a imagem deverá utilizar o asset squirtle.
            return .squirtle
        default:
            //Se o campo id for impar e não é multiplo de 5, a imagem deverá utilizar o asset bulbasaur.
            return .bulbasaur
        }
    }

}


