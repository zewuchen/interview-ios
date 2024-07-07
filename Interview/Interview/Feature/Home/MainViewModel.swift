//
//  MainViewModel.swift
//  Interview
//
//  Created by Kaled Jamal El Azanki on 02/07/24.
//

import Foundation
import UIKit

class MainViewModel {
    var pokemonList: PokemonDataModel?
    var error: String?
    let worker = PokemonNetworkManager()
    var tableViewUpdate: (() -> Void)?

    func getPokemonData() {
        worker.getPokemon { result in
            switch result {
            case .success(let data):
                self.pokemonList = data
                DispatchQueue.main.async {
                    self.tableViewUpdate?()
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
    
    func checkBackground(_ index: Int) -> UIColor {
        let numeroPar = index % 2 == 0
        let multiploDez = index % 10 == 0

        switch numeroPar {
        case false:
            return .blue
        case true && multiploDez == true:
            return .red
        default:
            return .yellow
        }
    }
    
}
