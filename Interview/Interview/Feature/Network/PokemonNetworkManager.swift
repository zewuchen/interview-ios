//
//  PokemonNetworkManager.swift
//  Interview
//
//  Created by Kaled Jamal El Azanki on 02/07/24.
//

import Foundation

class PokemonNetworkManager {
    private let urlSession: URLSession
    private let cache: URLCache
    
    init() {
        let memoryCapacity = 10 * 1024 * 1024
        let diskCapacity = 50 * 1024 * 1024
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "pokemonCache")
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.urlCache = cache
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        
        urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    private func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
            return
        }
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            do {
                let pokemonData = try JSONDecoder().decode(T.self, from: cachedResponse.data)
                completion(.success(pokemonData))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let data = data,
            let response = response {
                do {
                    let pokemonData = try JSONDecoder().decode(T.self, from: data)
                    
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                    
                    completion(.success(pokemonData))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    func getPokemon(completion: @escaping (Result<PokemonDataModel, Error>) -> Void) {
        let url = PokemonEndPoint.getPokemonUrl
        fetchData(from: url, completion: completion)
    }

    func getPokemonDetail(idPokemon: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        let url = PokemonEndPoint.getPokemonUrl + String(idPokemon)
        fetchData(from: url, completion: completion)
    }
}
