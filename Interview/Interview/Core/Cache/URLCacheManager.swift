//
//  URLCacheManager.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import Foundation

class URLCacheManager {
    static let shared = URLCacheManager()
    
    private let cache: URLCache
    
    private init() {
        let memoryCapacity = 50 * 1024 * 1024 // 50 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let diskPath = "pokemon_cache"
        
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
        URLCache.shared = cache
    }
    
    func getCachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return cache.cachedResponse(for: request)
    }
    
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        cache.storeCachedResponse(cachedResponse, for: request)
    }
    
    func removeCachedResponse(for request: URLRequest) {
        cache.removeCachedResponse(for: request)
    }
    
    func removeAllCachedResponses() {
        cache.removeAllCachedResponses()
    }
}
