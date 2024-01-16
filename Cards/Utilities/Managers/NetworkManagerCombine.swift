//  NetworkManagerCombine.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI
import Combine

class NetworkManagerCombine: NSObject {
    static let baseURLPerson = "https://randomuser.me/"
    private let personURL = baseURLPerson + "api/?inc=name,picture"
    
    static let baseURLAge = "https://api.agify.io/?name="
    static let ageURL = String()
    
    func fetchDataPerson() -> AnyPublisher<PersonResponse, Error> {
        guard let url = URL(string: personURL) else {
            assertionFailure(APError.invalidURL.localizedDescription)
            return Empty(completeImmediately: true)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PersonResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
