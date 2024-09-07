//
//  ServiceProxy.swift
//  Interview
//
//  Created by Rafael Ramos on 07/09/24.
//

import Foundation

protocol ServiceProxyProtocol: NetworkerProtocol {}

final class ServiceProxy: ServiceProxyProtocol {
    private let networker: NetworkerProtocol
    private let cacheWorker: CacheworkerProtocol
    
    init(networker: NetworkerProtocol, cacheWorker: CacheworkerProtocol) {
        self.networker = networker
        self.cacheWorker = cacheWorker
    }
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        cachePolicy: URLRequest.CachePolicy,
        completion: @escaping ((Result<T, NetworkerError>) -> Void)
    ) {
        Task {
            Logging.debug(message: "Will request to \(endpoint.baseUrl)", _class: Self.self)
            
            switch await loadFromCache(endpoint: endpoint) as Result<T, NetworkerError> {
            case .success(let cacheResponse):
                Logging.debug(message: "Response from cache", _class: Self.self)
                completion(.success(cacheResponse))
            case .failure:
                let remoteResult: Result<T, NetworkerError> = await loadFromRemote(endpoint: endpoint, cachePolicy: cachePolicy)
                Logging.debug(message: "Response from network", _class: Self.self)
                completion(remoteResult)
            }
        }
    }
    
    private func loadFromCache<T: Decodable>(endpoint: Endpoint) async -> Result<T, NetworkerError> {
        return await withCheckedContinuation { continuation in
            return cacheWorker.request(endpoint: endpoint) { resul in
                guard case .success(let cacheResponse) = resul as Result<T, NetworkerError> else {
                    continuation.resume(returning: .failure(.notFound))
                    return
                }
                
                return continuation.resume(returning: .success(cacheResponse))
            }
        }
    }
    
    private func loadFromRemote<T: Decodable>(endpoint: Endpoint, cachePolicy: URLRequest.CachePolicy) async -> Result<T, NetworkerError> {
        return await withCheckedContinuation { continuation in
            return networker.request(endpoint: endpoint, cachePolicy: cachePolicy) { result in
                switch result as Result<T, NetworkerError> {
                case .success(let remoteResponse):
                    return continuation.resume(returning: .success(remoteResponse))
                case .failure(let failure):
                    return continuation.resume(returning: .failure(failure))
                }
            }
        }
    }
}
