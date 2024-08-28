//
//  Request.swift
//  Interview
//
//  Created by Natali Cabral on 24/08/24.
//

import Foundation

class Request {
    
    private let urlSession: URLSession
    private let userDefaults: UserDefaults
    
    init(sessionConfiguration: URLSessionConfiguration = .default, userDefaults: UserDefaults = .standard) {
        self.urlSession = URLSession(configuration: sessionConfiguration)
        self.userDefaults = userDefaults
    }
    
    private func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPokemon(completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        let url = PokemonEndPoint.getPokemonUrl
        fetchData(from: url, completion: completion)
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        fetchData(from: url, completion: completion)
    }
}
