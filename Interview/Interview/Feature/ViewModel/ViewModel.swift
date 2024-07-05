import Foundation
import UIKit

class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonListed = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?

    
    // Adiciona 1 ao index para igualar ao id pokemon
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonListed.firstIndex(of: pokemon) {
            return index + 1
        }
        //Nada retorna se Index não corresponder com lista.
        return 0
    }

    func colorCell(pokemon: Pokemon) -> UIColor {
        let index = getPokemonIndex(pokemon: pokemon)
        let color: UIColor
        if index % 2 == 0 {
            if index % 10 == 0 {
            color = .red
            } else {
            color = .yellow
        }
        } else {
        color = .blue
        }
        return color
    }
    
    // Busca dados pokemon
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        // Para resetar a tela de detalhes
        self.pokemonDetails = DetailPokemon(name: "", id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }

    // Busca dados pokemon
    func urlGetDetails(url: String) {
        // Para resetar a tela de detalhes
        self.pokemonDetails = DetailPokemon(name: "", id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailUrl(url: url) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
}
