//  CardListViewModel.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import SwiftUI
import Combine

final class CardListViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var alertItem: AlertItem?
    @Published var isLoading = true
    @Published var cards: [Card] = []
    var detailCard: Cards = Cards()
    
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
    
    // MARK: Public methods
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
    
    func saveDetailCards() {
        detailCard.cards = cards
    }
    
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
    
    // MARK: Private methods
    private func getPersonDescription(withPerson person: Person) {
        guard let personName = person.name.first.safePercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        do {
            let randomAge = try personNetworkService.randomAge(name: personName)
            let randomNationality = try personNetworkService.randomNationality(name: personName)
            let randomGender = try personNetworkService.randomGender(name: personName)
            
            randomAge
                .combineLatest(randomNationality, randomGender)
                .sink { (age, nationality, gender) in
                    self.createNewCard(person, age, nationality, gender)
                }
                .store(in: &cancellables)
        } catch(let error) {
            print(error)
        }
    }
    
    private func createNewCard(
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
    
    private func appendNewCard(forCard card: Card) {
        cardStorageService.appendNewCard(forCards: card)
        loadFromStorage()
    }
}
