//
//  MainViewModel.swift
//  Interview
//
//  Created by Natali Cabral on 25/08/24.
//

import Foundation
import UIKit

struct PokemonRowModel {
    let pokemonName: String
    let backGround: UIColor
    let textColor: UIColor
    let url: String
}


class MainViewModel: MainViewModelDelegate {
    
    private var pokemonList: PokemonModel?
    private var error: String?
    private let worker = Request()
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
        
        let isEven = index % 2 == 0
        let isMultipleOfTen = index % 10 == 0
        
        if isEven && isMultipleOfTen {
            return (.red, .white)
        } else if isEven {
            return (.yellow, .black)
        } else {
            return (.blue, .white)
        }
    }
    
}
