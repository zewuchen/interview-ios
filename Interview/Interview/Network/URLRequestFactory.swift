//
//  URLRequestFactory.swift
//  Interview
//
//  Created by Rafael Ramos on 07/09/24.
//

import Foundation

enum URLRequestFactory {
    static func make(from endpoint: Endpoint, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) -> URLRequest? {
        let urlString: String = "https://\(endpoint.host)\(endpoint.baseUrl)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.cachePolicy = cachePolicy
        urlRequest.httpMethod = endpoint.method.rawValue
        
        return urlRequest
    }
}
