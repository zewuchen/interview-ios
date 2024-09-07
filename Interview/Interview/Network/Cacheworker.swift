//
//  Cacheworker.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation

final class URLCacheFactory {
    private var sharedURLCache: URLCache = URLCache.shared
    
    /// 4 MB to memory
    private let memoryCapacity = 4 * 1024 * 1024
    /// 100 MB to disk
    private let diskCapacity = 100 * 1024 * 1024
    private let diskPath: String = "pokemon_cache"
    
    static let shared: URLCacheFactory = .init()
    
    private init()  {}
    
    func make() -> URLCache {
        sharedURLCache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: diskPath
        )
        
        return sharedURLCache
    }
}

protocol CacheworkerProtocol {
    func request<T: Decodable>(endpoint: Endpoint, cachePolicy: URLRequest.CachePolicy, completion: @escaping ((Result<T, NetworkerError>) -> Void))
    func storeCachedResponse(_ urlResponse: URLResponse, for urlRequest: URLRequest, data: Data)
}

final class Cacheworker: CacheworkerProtocol {
    private var urlCache: URLCache
    private let jsonDecoder: JSONDecoder
    
    init(urlCache: URLCache, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlCache = urlCache
        self.jsonDecoder = jsonDecoder
    }
    
    func storeCachedResponse(_ urlResponse: URLResponse, for urlRequest: URLRequest, data: Data) {
        let cacheResponse: CachedURLResponse = .init(response: urlResponse, data: data)
        urlCache.storeCachedResponse(cacheResponse, for: urlRequest)
    }
    
    func request<T: Decodable>(endpoint: Endpoint, cachePolicy: URLRequest.CachePolicy, completion: @escaping ((Result<T, NetworkerError>) -> Void)) {
        guard let urlRequest = URLRequestFactory.make(from: endpoint, cachePolicy: cachePolicy) else {
            completion(.failure(.notFound))
            return
        }
        
        guard let cacheResponse = urlCache.cachedResponse(for: urlRequest) else {
            completion(.failure(.notFound))
            return
        }
        
        do {
            let response: T = try jsonDecoder.decode(T.self, from: cacheResponse.data)
            completion(.success(response))
        } catch {
            completion(.failure(NetworkerError.parseError))
        }
    }
}
