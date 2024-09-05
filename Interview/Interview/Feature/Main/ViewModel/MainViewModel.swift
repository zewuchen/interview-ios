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
    
    func getScreenTitle() -> String
    func getNumberOfRows() -> Int
    func getPokemonRow(from row: Int) -> PokemonRow?
    func fetchPokemons()
    
    func setDelegate(_ delegate: MainViewModelOutput?)
}

protocol MainViewModelOutput: AnyObject {
    func willLoadPokemons(message: String)
    func loadedPokemonsWithSuccess()
    func loadedPokemonsWithFailure()
}

final class MainViewModel {
    // Using NSLock to avoid data race
    private let nsLock: NSLock = .init()
    private let pokemonWorker: PokemonWorkerProtocol
    private let pokemonRowRuleUseCase: PokemonRowRuleUseCaseProtocol
    
    private var pokemons: [PokemonRow] = []
    
    var forCellReuseIdentifier: String {
        return String(describing: PokemonTableViewCell.self)
    }
    
    weak var delegate: MainViewModelOutput?
    
    init(
        pokemonWorker: PokemonWorkerProtocol,
        pokemonRowRuleUseCase: PokemonRowRuleUseCaseProtocol
    ) {
        self.pokemonWorker = pokemonWorker
        self.pokemonRowRuleUseCase = pokemonRowRuleUseCase
    }
}

extension MainViewModel: MainViewModelProtocol {
    func setDelegate(_ delegate: MainViewModelOutput?) {
        self.delegate = delegate
    }
    
    func fetchPokemons() {
        delegate?.willLoadPokemons(message: "Carregando")
        
        var index: Int = 0
        pokemonWorker.fetchPokemons { [weak self] result in
            guard case .success(let response) = result, let results = response.results else {
                self?.delegate?.loadedPokemonsWithFailure()
                return
            }
            
            self?.handlePokemonList(from: results, index: &index)
            
            self?.delegate?.loadedPokemonsWithSuccess()
        }
    }
    
    func getPokemonRow(from row: Int) -> PokemonRow? {
        nsLock.lock()
        let pokemon: PokemonRow? = pokemons.object(index: row)
        nsLock.unlock()
        
        return pokemon
    }
    
    func getNumberOfRows() -> Int {
        nsLock.lock()
        let numberOfRows: Int = pokemons.count
        nsLock.unlock()
        return numberOfRows
    }
    
    func getScreenTitle() -> String {
        return "Pokemons"
    }
}

private extension MainViewModel {
    func handlePokemonList(from results: [PokemonEntityResponse], index: inout Int) {
        results.forEach {
            guard let name = $0.name else { return }
            
            index += 1
            
            pokemons.append(PokemonRow(
                title: getRowTitle(index: index, name: name),
                background: getRowBackground(index: index)
            ))
        }
    }
    
    func getRowTitle(index: Int, name: String) -> String {
        return "\(index) - \(name)"
    }
    
    func getRowBackground(index: Int) -> UIColor {
        pokemonRowRuleUseCase.getRowBackground(index: index)
    }
}
