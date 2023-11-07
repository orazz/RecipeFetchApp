//
//  File.swift
//
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

final public class ApiImpl: Api {
    
    private var sessionManager: URLSession
    
    public init() {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        sessionManager = URLSession(configuration: config)
    }
    
    public func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: NetworkError.serverConnectionFailed)
                return
            }
            let task = sessionManager.dataTask(with: route.asURLRequest()) { data, response, error in
                #if DEBUG
//                print("Result:\n\(String(data: data ?? Data(), encoding: .utf8) ?? "result")")
                #endif
                guard error == nil else {
                    continuation.resume(throwing: NetworkError.jsonParsingFailed)
                    return
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.validateResponse(data: data, urlResponse: response, error: error)
                    switch result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let decodableData = try decoder.decode(type, from: data)
                            continuation.resume(returning: decodableData)
                        } catch {
                            continuation.resume(throwing: NetworkError.jsonParsingFailed)
                        }
                    case .failure:
                        continuation.resume(throwing: NetworkError.serverConnectionFailed)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    public func fetchImageData(route: ApiRouter) async throws -> Data {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: NetworkError.serverConnectionFailed)
                return
            }
            
            let task = sessionManager.dataTask(with: route.asURLRequest()) { data, response, error in
                if let response = response as? HTTPURLResponse {
                    let result = self.validateResponse(data: data, urlResponse: response, error: error)
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure:
                        continuation.resume(throwing: NetworkError.serverConnectionFailed)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func validateResponse(data: Data?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Data, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(NetworkError.jsonParsingFailed)
            }
        case 400...599:
            return .failure(NetworkError.jsonParsingFailed)
        default:
            return .failure(NetworkError.invalidURL)
        }
    }
}
