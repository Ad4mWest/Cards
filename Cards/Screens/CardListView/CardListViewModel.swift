//  CardListViewModel.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import Foundation
import Combine

final class CardListViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var cards: [Card] = []
    @Published var alertItem: AlertItem?
    
    // MARK: Private properties
    private var cancellables = Set<AnyCancellable>()
    private let personNetworkService: PersonNetworkService
    
    // MARK: Initialization
    init(personNetworkService: PersonNetworkService) {
        self.personNetworkService = personNetworkService
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
            .sink { completion in
                if case .failure = completion {
                    self.alertItem = AlertContext.invalidData
                }
            } receiveValue: { person in
                self.getPersonDescription(withPerson: person)
            }
            .store(in: &cancellables)
    }
    
    private func getPersonDescription(withPerson person: Person) {
        guard let personName = person.name.first.safePercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        personNetworkService.randomAge(name: personName)
            .combineLatest(
                personNetworkService.randomNationality(name: personName),
                personNetworkService.randomGender(name: personName)
            )
            .sink { completion in
                if case .failure = completion {
                    self.alertItem = AlertContext.invalidResponse
                }
            } receiveValue: { (age, nationality, gender) in
                let id = UUID()
                guard let nationality = nationality.country.first else { return }
                let card = Card(
                    id: id,
                    name: person.name.title + " " + person.name.first + " " + person.name.last,
                    imageURL: person.picture.large,
                    age: age.age,
                    gender: gender.gender ?? "Agender",
                    nationality: nationality.countryId,
                    email: person.email,
                    phone: person.phone
                )
                self.cards.append(card)
            }
            .store(in: &cancellables)
    }
}
