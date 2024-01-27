//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var alertItem: AlertItem?
    
    var card: Card
    var discardCard: Card = Card()
    var angularGradient: AngularGradient {
        AngularGradient(
            gradient: self.colors,
            center: .center)
    }
    
    // MARK: Delegate
    public var delegate: CardListViewModelDelegate?
    
    // MARK: Private properties
    private var colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple])
    private let cardStorageService: CardStorageService
    
    // MARK: Initialization
    init(
        card: Card,
        cardStorageService: CardStorageService,
        delegate: CardListViewModelDelegate?
    ) {
        self.card = card
        self.cardStorageService = cardStorageService
        self.delegate = delegate
        self.discardCard = card
    }
    
    // MARK: Public methods
    func saveCurrentCard() {
        cardStorageService.editCurrentCard(forCards: card)
        discardCard = card
        delegate?.buttonSaveTapped()
        alertItem = AlertContext.userSaveSuccess
    }
    
    func discardChanges() {
        card = discardCard
        alertItem = AlertContext.discardCardChanges
    }
}
