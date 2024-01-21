//  NetworkService.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation
import Combine

protocol NetworkService {
    func fetchData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}

extension NetworkService {
    func fetchData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

