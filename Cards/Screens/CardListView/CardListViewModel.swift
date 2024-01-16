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
    
    private var cancellables = Set<AnyCancellable>()
    private var apiClient = NetworkManagerCombine()
    
    func getPersonName() {
        id += 1
        apiClient.fetchDataPerson()
            .sink { completion in
                if case .failure(let error) = completion {
                    assertionFailure(error.localizedDescription)
                }
            } receiveValue: { person in
                self.cards.append(Card(
                    id: self.id,
                    name: "\(person.results[0].name.title) \(person.results[0].name.first) \(person.results[0].name.last)",
                    imageURL: person.results[0].picture.large,
                    age: 5,
                    gender: "Male",
                    nationality: "Russian"))
            }
            .store(in: &cancellables)
    }
}
