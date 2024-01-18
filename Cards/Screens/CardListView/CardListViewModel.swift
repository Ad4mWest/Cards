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
    private var cancellables = Set<AnyCancellable>()
    private let personNetworkService: PersonNetworkService
    
    // MARK: Initialization
    init(apiClient: PersonNetworkService) {
        self.personNetworkService = apiClient
    }
    
    /// Combine data from Apies to Card
    /// - Parameters:
    ///         - randomPerson()
    ///         - randomAge(name: )
    ///         - randomNationality(name: )
    ///         - randomGender(name: )
    /// - Results: Card()
    
    func getNewCard() {
        personNetworkService.randomPerson()
            .compactMap { $0.results.first }
            .sink { _ in } receiveValue: { person in
                self.getPersonDescription(withPerson: person)
            }
            .store(in: &cancellables)
    }
    
    private func getPersonDescription(withPerson person: Person) {
        personNetworkService.randomAge(name: person.name.first)
            .combineLatest(personNetworkService.randomNationality(name: person.name.first))
                           //personNetworkService.randomGender(name: person.name.first))
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { (age, nationality) in //, gender) in
                let id = UUID()
                guard let nationality = nationality.country.first else { return }
                let card = Card(
                    id: id,
                    name: person.name.title + " " + person.name.first + " " + person.name.last,
                    imageURL: person.picture.large,
                    age: age.age,
                    gender: person.gender, //gender.gender ?? "Agender",
                    nationality: nationality.country_id,
                    email: person.email,
                    phone: person.phone
                )
                self.cards.append(card)
            }
            .store(in: &cancellables)
    }
}
