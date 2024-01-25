//  NetworkService.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation
import Combine

enum APiError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

protocol NetworkService {
    func fetchData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}

extension NetworkService {
    func fetchData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APiError.unknown
                }
                return data
            }
            .mapError { error in
                if let error = error as? APiError {
                    return error
                } else {
                    return APiError.apiError(reason: error.localizedDescription)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}





