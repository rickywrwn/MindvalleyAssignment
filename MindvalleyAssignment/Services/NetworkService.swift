//
//  NetworkService.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func request<T: Codable>(endpoint: Endpoint) async -> Result<T, NetworkError>
}

// MARK: - Network Service Implementation
final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable>(endpoint: Endpoint) async -> Result<T, NetworkError> {
            // Create URL
            guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
                return .failure(.invalidURL)
            }
            
            // Create request
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            
            // Handle parameters
            if let parameters = endpoint.parameters {
                if endpoint.method == .get {
                    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    components?.queryItems = parameters.map {
                        URLQueryItem(name: $0.key, value: "\($0.value)")
                    }
                    guard let url = components?.url else {
                        return .failure(.invalidURL)
                    }
                    request.url = url
                } else {
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                    } catch {
                        return .failure(.encodingError)
                    }
                }
            }
            
            do {
                let (data, response) = try await session.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return .failure(.serverError(0))
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    return .failure(.serverError(httpResponse.statusCode))
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    return .failure(.decodingError)
                }
            } catch {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    return .failure(.noConnection)
                } else if (error as NSError).code == NSURLErrorTimedOut {
                    return .failure(.timeout)
                }
                return .failure(.custom(error.localizedDescription))
            }
        }
}
