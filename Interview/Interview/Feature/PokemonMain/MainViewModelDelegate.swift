//
//  MainViewModelDelegate.swift
//  Interview
//
//  Created by Natali Cabral on 26/08/24.
//

import Foundation


protocol MainViewModelDelegate {
    func getPokemonData()
    func countOfPokemons() -> Int
    func getPokemon(for index: Int) -> PokemonRowModel
    var viewControllerDelegate: MainViewControllerDelegate? { get set }
}
