//  CardListViewModel.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import Foundation
import Combine

final class CardListViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedCard: Card?
    private var id: Int = 0
    private var name = "adam"
    
    private var cancellables = Set<AnyCancellable>()
    private var apiClient: PersonNetworkService
    
    init(apiClient: PersonNetworkService) {
        self.apiClient = apiClient 
    }
    
    func getNewCard() {
        id += 1
        apiClient.randomPerson()
            .combineLatest(apiClient.randomAge(name: name),
                           //apiClient.randomGender(name: name),
                           apiClient.randomNationality(name: name))
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { (person, age,  nationality) in // gender,
                guard let person = person.results.first else { return }
                guard let nationality = nationality.country.first else { return }
                self.name = person.name.first
                self.cards.append(Card(
                    id: self.id,
                    name: person.name.title + " " + person.name.first + " " + person.name.last,
                    imageURL: person.picture.large,
                    age: age.age,
                    gender: person.gender, // gender.gender,
                    nationality: nationality.country_id))
                
            }
            .store(in: &cancellables)
        
        apiClient.randomAge(name: name)
            .sink { _ in } receiveValue: { person in
                print(person.age)
            }
            .store(in: &cancellables)
        
//        apiClient.randomGender(name: name)
//            .sink { _ in } receiveValue: { person in
//                print(person.gender)
//            }
//            .store(in: &cancellables)
        
        apiClient.randomNationality(name: name)
            .compactMap { $0.country.first }
            .sink { _ in } receiveValue: { person in
                print(person.country_id)
            }
            .store(in: &cancellables)
    }
}
