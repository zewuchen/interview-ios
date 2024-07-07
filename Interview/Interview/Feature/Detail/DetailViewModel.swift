//
//  DetailViewModel.swift
//  Interview
//
//  Created by Kaled Jamal El Azanki on 03/07/24.
//

import Foundation

enum PokemonsImage: String {
    case squirtle
    case bulbasaur
    case charmander
}

class DetailViewModel {
    var pokemonDetails: PokemonDetail?
    var error: String?
    let worker = PokemonNetworkManager()
    var tableViewUpdate: (() -> Void)?

    func getPokemonData(id: Int) {
        worker.getPokemonDetail(idPokemon: id) { result in
            switch result {
            case .success(let data):
                self.pokemonDetails = data
                DispatchQueue.main.async {
                    self.tableViewUpdate?()
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
    
    func showPokemonImage(_ id: Int) -> PokemonsImage {
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
