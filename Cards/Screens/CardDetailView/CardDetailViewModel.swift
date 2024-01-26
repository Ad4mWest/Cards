//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var card: Card
    @Published var alertItem: AlertItem?
    var angularGradient: AngularGradient {
        AngularGradient(
            gradient: self.colors,
            center: .center)
    }
    
    // MARK: Private properties
    private var colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple])
    private var containerCard: Card = Card()
    private let cardStorageService: CardStorageService
    
    // MARK: Initialization
    init(card: Card, cardStorageService: CardStorageService) {
        self.card = card
        self.cardStorageService = cardStorageService
        containerCard = card
    }
    
    // MARK: Public methods
    func editCurrentCard(forCards card: Card, toCards cards: Cards) {
        cardStorageService.editCurrentCard(forCards: card)
        cards.cards = cardStorageService.loadFromStorageCards()
        alertItem = AlertContext.userSaveSuccess
    }
    
    func discardChanges() {
        card = containerCard
        alertItem = AlertContext.discardCardChanges
    }
}
