import Foundation


struct DetailPage: Codable {
    let count: Int
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "butterfree", url: "https://pokeapi.co/api/v2/pokemon/12/")
}

struct DetailPokemon: Codable {
    let name: String
    let id: Int
    let height: Int
    let weight: Int
}