import Foundation

protocol APIServiceProtocol {
    func get<T: Decodable>(request: URLRequest, of type: T.Type, completion: @escaping (Result<T, ServiceError>) -> Void)
}

class APIService: APIServiceProtocol {
    let session: URLSession
    let cacheManager: URLCacheManager
    
    init(session: URLSession = .shared, cacheManager: URLCacheManager = .shared) {
        self.session = session
        self.cacheManager = cacheManager
    }
    
    func get<T: Decodable>(request: URLRequest, of type: T.Type, completion: @escaping (Result<T, ServiceError>) -> Void) {
        if let cachedResponse = cacheManager.getCachedResponse(for: request) {
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: cachedResponse.data)
                completion(.success(decodedObject))
                return
            } catch {}
        }
        
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(description: error.localizedDescription)))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                if let httpResponse = response as? HTTPURLResponse {
                    let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
                    self?.cacheManager.storeCachedResponse(cachedResponse, for: request)
                }
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
