//
//  MainViewModel.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation

protocol MainViewModelProtocol {
    var pokemons: [Pokemon] { get }
    var coordinator: MainCoordinatorNavigation? { get set }

    func fetchAllPokemons()
    func didSelectPokemon(at index: Int)
    
    var onPokemonsUpdated: ((_ pokemons: [PokemonListCellModel]) -> Void)? { get set }
}

class MainViewModel: MainViewModelProtocol {
    
    //MARK: ViewModel Protocol
    var coordinator: MainCoordinatorNavigation?
    private(set) var pokemons: [Pokemon] = []
    var onPokemonsUpdated: ((_ pokemons: [PokemonListCellModel]) -> Void)?
    
    // MARK: Dependencies
    private let pokemonService: PokemonService
    
    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }
    
    func fetchAllPokemons() {
        pokemonService.fetchPokemons { result in
            switch result {
            case .success(let list):
                self.pokemons = list.results
                self.updateTable()
            case .failure: break
            }
        }
    }
    
    func didSelectPokemon(at index: Int) {
        guard index < pokemons.count else { return }
        guard let url = pokemons[index].url else {
            return
        }
        
        coordinator?.showPokemonDetails(with: url)
    }
}

// MARK: Utils
private extension MainViewModel {
    func updateTable() {
        let list = createCellsModel()
        self.onPokemonsUpdated?(list)
    }
    
    func createCellsModel() -> [PokemonListCellModel] {
        let list = self.pokemons.enumerated().map { (index, pokemon) in
            let index = index + 1
            return PokemonListCellModel(title: "\(index) - \(pokemon.name)", type: getPokemonType(index))
        }
        
        return list
    }
    
    func getPokemonType(_ index: Int) -> PokemonCellType {
        if index % 2 != 0 {
            return .blue
        } else if index % 10 == 0 {
            return .red
        } else {
            return .yellow
        }
    }
}
