//
//  MainViewModel.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation
import UIKit

protocol MainViewModelDelegate {
    func getPokemonData()
    func countOfPokemons() -> Int
    func getPokemon(for index: Int) -> PokemonRowModel
    var viewControllerDelegate: MainViewControllerDelegate? { get set }
}

class MainViewModel: MainViewModelDelegate {

    private var pokemonList: PokemonModel?
    private var error: String?
    private let worker = Service()
    weak var viewControllerDelegate: MainViewControllerDelegate?

    public func getPokemonData() {
        viewControllerDelegate?.showLoading()

        worker.getPokemon { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.pokemonList = data
                    self.viewControllerDelegate?.reloadData()
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.viewControllerDelegate?.showError()
                }
                self.viewControllerDelegate?.hideLoading()
            }
        }
    }

    public func countOfPokemons() -> Int {
        return pokemonList?.results.count ?? 0
    }

    public func getPokemon(for index: Int) -> PokemonRowModel {
        let pokemon = pokemonList?.results[index]
        let colors = checkBackground(index + 1)
        return PokemonRowModel(pokemonName: pokemon?.name ?? "", backGround: colors.background, textColor: colors.textColor, url: pokemon?.url ?? "")
    }

    private func checkBackground(_ index: Int) -> (background: UIColor, textColor: UIColor) {
        let numeroPar = index % 2 == 0
        let multiploDez = index % 10 == 0

        switch numeroPar {
        case false:
            return (.blue, .white)
        case true && multiploDez == true:
            return (.red, .white)
        default:
            return (.yellow, .black)
        }
    }

}
