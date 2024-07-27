//
//  Service.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation

class Service {

    private let urlSession: URLSession
    private let cache: URLCache
    private let userDefaults: UserDefaults
    private let cacheKey = "pokemonCacheKey"

    init() {
        let memoryCapacity = 10 * 1024 * 1024
        let diskCapacity = 50 * 1024 * 1024
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "pokemonCache")

        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.urlCache = cache
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad

        urlSession = URLSession(configuration: sessionConfiguration)
        userDefaults = UserDefaults.standard
    }

    private func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
            return
        }

        validateLocalCache(url: url.absoluteString, completion: completion)
        validateURLCache(url: url, completion: completion)

        urlSession.dataTask(with: url) { data, response, error in
            if let data = data, let response = response {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)

                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                    self.userDefaults.set(data, forKey: self.cacheKey + url.absoluteString)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    private func validateLocalCache<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)  {
        if let cachedData = userDefaults.data(forKey: cacheKey + url) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: cachedData)
                completion(.success(decodedData))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
    }

    private func validateURLCache<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)  {
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: cachedResponse.data)
                completion(.success(decodedData))
                userDefaults.set(cachedResponse.data, forKey: cacheKey + url.absoluteString)
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
    }

    func getPokemon(completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        let url = PokemonEndPoint.getPokemonUrl
        fetchData(from: url, completion: completion)
    }

    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        fetchData(from: url, completion: completion)
    }

}
