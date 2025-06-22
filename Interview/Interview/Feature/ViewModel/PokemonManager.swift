import Foundation

class PokemonManager {
    func getPokemon() -> [Pokemon] {
        let data: PokemonList = Bundle.main.decode(file:"pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailPokemon(id: Int, _ completion:@escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            completion(data)
            //Se tiver sucesso, retornar dados.
            print(data)

          //Se tiver error, retornar erro.  
        } failure: { error in
            print(error)
        }
    }

    func getDetailUrl(url: String, _ completion:@escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: url, model: DetailPokemon.self) { data in
            completion(data)
            //Se tiver sucesso, retornar dados.
            print(data)

          //Se tiver error, retornar erro.  
        } failure: { error in
            print(error)
        }
    }
}