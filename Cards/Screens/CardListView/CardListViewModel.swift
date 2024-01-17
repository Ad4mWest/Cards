//  CardListViewModel.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import Foundation
import Combine

final class CardListViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var cards: [Card] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    // MARK: Private properties
    private var name = String()
    private var cancellables = Set<AnyCancellable>()
    private let apiClient: PersonNetworkService
    
    // MARK: Initialization
    init(apiClient: PersonNetworkService) {
        self.apiClient = apiClient 
    }
    
    /// Combine data from Apies to Card
    /// - Parameters:
    ///         - randomPerson()
    ///         - randomAge(name: name)
    ///         - randomNationality(name: name)
    
    func getNewCard() {
        let id = UUID()
        apiClient.randomPerson()
            .combineLatest(apiClient.randomAge(name: name),
                           apiClient.randomNationality(name: name))
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { (person, age,  nationality) in
                guard let person = person.results.first else { return }
                guard let nationality = nationality.country.first else { return }
                self.name = person.name.first
                let card = Card( ///         - Returns: Card()
                    id: id,
                    name: person.name.title + " " + person.name.first + " " + person.name.last,
                    imageURL: person.picture.large,
                    age: age.age,
                    gender: person.gender,
                    nationality: nationality.country_id,
                    email: person.email,
                    phone: person.phone
                )
                self.cards.append(card)
            }
            .store(in: &cancellables)
        
        apiClient.randomAge(name: name)
            .sink { _ in } receiveValue: { person in
                print(person.age)
            }
            .store(in: &cancellables)
        
        apiClient.randomNationality(name: name)
            .compactMap { $0.country.first }
            .sink { _ in } receiveValue: { person in
                print(person.country_id)
            }
            .store(in: &cancellables)
    }
}
