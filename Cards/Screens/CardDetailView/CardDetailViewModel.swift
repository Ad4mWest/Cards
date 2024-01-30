//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var alertItem: AlertItem?
    @Published var editingButtonsHidden = true
    @Published var angle: Double = 0

    var card: Card
    var discardCard: Card = Card()
    
    // MARK: Delegate
    weak var delegate: CardListViewModelDelegate?
    
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
        guard isValidForm else {
            return
        }
        cardStorageService.editCurrentCard(forCards: card)
        discardCard = card
        delegate?.buttonSaveTapped()
        DispatchQueue.main.async {
            self.alertItem = AlertContext.userSaveSuccess
        }
    }
    
    func discardChanges() {
        card = discardCard
        DispatchQueue.main.async {
            self.angle += 30
            self.alertItem = AlertContext.discardCardChanges
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.angle = 0
        }
    }
    
    func editingButtonsHiddens() {
        if isValidForm {
            editingButtonsHidden = true
        }
    }
}

// MARK: - Validation
extension CardDetailViewModel {
    var isValidForm: Bool {
        guard !card.name.isEmpty &&
                !card.email.isEmpty &&
                !card.phone.isEmpty &&
                !card.gender.isEmpty &&
                !String(card.age).isEmpty &&
                !card.nationality.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        guard card.gender.isValidGender else {
            alertItem = AlertContext.invalidGender
            return false
        }
        
        guard String(card.age).isValidAge else {
            alertItem = AlertContext.invalidAge
            return false
        }
        
        guard card.nationality.isValidNationality else {
            alertItem = AlertContext.invalidNationality
            return false
        }
        
        guard card.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    // MARK: Gradient
    var angularGradient: AngularGradient {
        AngularGradient(
            gradient: self.colors,
            center: .center
        )
    }
}
