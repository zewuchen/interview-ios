//
//  Networker.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol NetworkerProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint,
        cachePolicy: URLRequest.CachePolicy,
        cacheWorker: CacheworkerProtocol,
        completion: @escaping ((Result<T, NetworkerError>) -> Void)
    )
}

final class Networker: NetworkerProtocol {
    
    private let urlSession: URLSessionProtocol
    private let jsonNDecoder: JSONDecoder
    
    init(
        urlSession: URLSessionProtocol,
        jsonNDecoder: JSONDecoder
    ) {
        self.urlSession = urlSession
        self.jsonNDecoder = jsonNDecoder
    }
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        cachePolicy: URLRequest.CachePolicy,
        cacheWorker: CacheworkerProtocol,
        completion: @escaping ((Result<T, NetworkerError>) -> Void)
    ) {
        guard let urlRequest = URLRequestFactory.make(from: endpoint, cachePolicy: cachePolicy) else {
            completion(.failure(.unknown("URLRequest is nil")))
            return
        }
        
        let dataTask: URLSessionDataTaskProtocol = urlSession.dataTask(request: urlRequest) { data, response, _ in
            self.handleResponse(urlRequest: urlRequest, response: response, data: data, cacheWorker: cacheWorker) { result in
                switch result {
                case .success(let data):
                    do {
                        let result: T = try self.jsonNDecoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.parseError))
                    }
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func handleResponse(
        urlRequest: URLRequest,
        response: URLResponse?,
        data: Data?,
        cacheWorker: CacheworkerProtocol,
        completion: @escaping ((Result<Data, NetworkerError>) -> Void)
    ) {
        guard let response = response, let statusCode: Int = (response as? HTTPURLResponse)?.statusCode else {
            completion(.failure(.unknown("HTTPURLResponse is nil")))
            return
        }
        
        guard statusCode >= 200 && statusCode < 300 else {
            completion(.failure(NetworkerError(statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.failure(.unknown("Data is nil")))
            return
        }
        
        cacheWorker.storeCachedResponse(response, for: urlRequest, data: data)
        
        completion(.success(data))
    }
}
