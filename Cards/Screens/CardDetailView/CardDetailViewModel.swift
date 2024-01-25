//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var card: Card
    
    // MARK: Private properties
    private let cardStorageService: CardStorageService
    
    // MARK: Initialization
    init(card: Card, cardStorageService: CardStorageService) {
        self.card = card
        self.cardStorageService = cardStorageService
    }
    
    // MARK: Public methods
    func editCurrentCard(forCards card: Card, toCards cards: Cards) {
        cardStorageService.editCurrentCard(forCards: card)
        cards.cards = cardStorageService.loadFromStorageCards()
    }
}
