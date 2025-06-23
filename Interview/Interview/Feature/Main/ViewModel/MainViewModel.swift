//
//  MainViewModel.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    var forCellReuseIdentifier: String { get }
    
    func getPokemonList() -> [PokemonRow]
    func fetchPokemons()
    
    func setDelegate(_ delegate: MainViewModelOutput?)
}

protocol MainViewModelOutput: AnyObject {
    func willLoadPokemons(message: String)
    func loadedPokemonsWithSuccess()
    func loadedPokemonsWithFailure(message: String)
}

final class MainViewModel {
    private let pokemonWorker: PokemonWorkerProtocol
    private let pokemonRowBackgroundColorUserCase: PokemonRowBackgroundUseCaseProtocol
    
    private var pokemons: [PokemonRow] = []
    
    var forCellReuseIdentifier: String {
        return String(describing: PokemonTableViewCell.self)
    }
    
    weak var delegate: MainViewModelOutput?
    
    init(
        pokemonWorker: PokemonWorkerProtocol,
        pokemonRowBackgroundColorUserCase: PokemonRowBackgroundUseCaseProtocol
    ) {
        self.pokemonWorker = pokemonWorker
        self.pokemonRowBackgroundColorUserCase = pokemonRowBackgroundColorUserCase
    }
}

extension MainViewModel: MainViewModelProtocol {
    func setDelegate(_ delegate: MainViewModelOutput?) {
        self.delegate = delegate
    }
    
    func fetchPokemons() {
        delegate?.willLoadPokemons(message: Constants.Strings.loading)
        
        var index: Int = 0
        pokemonWorker.fetchPokemons { [weak self] result in
            guard case .success(let response) = result, let results = response.results else {
                self?.delegate?.loadedPokemonsWithFailure(message: Constants.Strings.errorLoading)
                return
            }
            
            self?.handlePokemonList(from: results, index: &index)
            
            self?.delegate?.loadedPokemonsWithSuccess()
        }
    }
    
    func getPokemonList() -> [PokemonRow] {
        return pokemons
    }
}

private extension MainViewModel {
    func handlePokemonList(from results: [PokemonEntityResponse], index: inout Int) {
        results.forEach {
            guard let name = $0.name else { return }
            
            index += 1
            
            pokemons.append(PokemonRow(
                title: getRowTitle(index: index, name: name),
                background: getRowBackground(index: index),
                url: getURL(from: $0.url)
            ))
        }
    }
    
    func getRowTitle(index: Int, name: String) -> String {
        return "\(index) - \(name)"
    }
    
    func getRowBackground(index: Int) -> UIColor {
        pokemonRowBackgroundColorUserCase.getRowBackground(index: index)
    }
    
    func getURL(from value: String?) -> URL? {
        guard let value else { return nil }
        return URL(string: value)
    }
}
