//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var alertItem: AlertItem?
    @Published var editingButtonsHidden = true    
    var card: Card
    var discardCard: Card = Card()
    
    // MARK: Delegate
    weak var delegate: CardListViewModelDelegate?
    
    // MARK: Private properties
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
        self.alertItem = AlertContext.discardCardChanges
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
        guard
            card.name.isNotEmpty &&
                card.email.isNotEmpty &&
                card.phone.isNotEmpty &&
                card.gender.isNotEmpty &&
                String(card.age).isNotEmpty &&
                card.nationality.isNotEmpty
        else {
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
}
