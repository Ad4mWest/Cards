//  CardListViewModel.swift
//  Cards
//  Created by Adam West on 11.01.2024.

import SwiftUI
import Combine

protocol CardListViewModelDelegate: AnyObject {
    func buttonSaveTapped()
}

final class CardListViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var alertItem: AlertItem?
    @Published var cards: [Card] = []
    
    // MARK: Private properties
    private var cancellables = Set<AnyCancellable>()
    private let personNetworkService: PersonNetworkService
    private let cardStorageService: CardStorageService
    
    // MARK: Initialization
    init(
        personNetworkService: PersonNetworkService,
        cardStorageService: CardStorageService
    ) {
        self.personNetworkService = personNetworkService
        self.cardStorageService = cardStorageService
    }
    
    // MARK: Methods of storaging
    func remove(atOffsets indexSet: IndexSet) {
        cardStorageService.deleteCard(atOffsets: indexSet)
        cards = cardStorageService.loadFromStorageCards()
    }
    
    func onMove(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        cardStorageService.changePositionOfCards(fromOffsets: indices, toOffset: newOffset)
        cards = cardStorageService.loadFromStorageCards()
    }
    
    func loadFromStorage() {
        cards = cardStorageService.loadFromStorageCards()
    }
    
    // MARK: Methods of network service
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
}

// MARK: CardListViewModelDelegate
extension CardListViewModel: CardListViewModelDelegate {
    func buttonSaveTapped() {
        loadFromStorage()
    }
}

// MARK: Private methods
private extension CardListViewModel {
    func getPersonDescription(withPerson person: Person) {
        guard let personName = person.name.first.safePercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let randomAge = personNetworkService.randomAge(name: personName)
            .replaceError(with: AgeResponse())
        let randomNationality = personNetworkService.randomNationality(name: personName)
            .replaceError(with: NationalityResponse())
        let randomGender = personNetworkService.randomGender(name: personName)
            .replaceError(with: GenderResponse())
        
        randomAge
            .combineLatest(randomNationality, randomGender)
            .sink { (age, nationality, gender) in
                self.createNewCard(person, age, nationality, gender)
            }
            .store(in: &cancellables)
    }
    
    func createNewCard(
        _ person: Person,
        _ age: AgeResponse,
        _ nationality: NationalityResponse,
        _ gender: GenderResponse
    ) {
        let id = UUID()
        let card = Card(
            id: id,
            name: person.name.first + " " + person.name.last,
            imageURL: person.picture.large,
            age: age.age,
            gender: gender.gender ?? String(),
            nationality: nationality.country.first?.countryId ?? String(),
            email: person.email,
            phone: person.phone
        )
        appendNewCard(forCard: card)
    }
    
    func appendNewCard(forCard card: Card) {
        cardStorageService.appendNewCard(forCards: card)
        loadFromStorage()
    }
}
