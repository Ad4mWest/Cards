//  NetworkManagerCombine.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI
import Combine

class NetworkManagerCombine: NSObject {
    static let baseURL = "https://randomuser.me/"
    private let cardURL = baseURL + "api/?inc=name,picture"
    
    func fetchDataPerson() -> AnyPublisher<CardResponse, Error> {
        guard let url = URL(string: cardURL) else {
            assertionFailure(APError.invalidURL.localizedDescription)
            return Empty(completeImmediately: true)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CardResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
