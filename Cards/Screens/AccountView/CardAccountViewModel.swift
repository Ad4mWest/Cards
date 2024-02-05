//  CardAccountViewModel.swift
//  Cards
//  Created by Adam West on 20.01.2024.

import SwiftUI

final class CardAccountViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var card: Card = Card()
    @Published var alertItem: AlertItem?
    
    // MARK: Private properties
    private let profileStorageService: ProfileStorageService
    
    // MARK: Initialization
    init(profileStorageService: ProfileStorageService) {
        self.profileStorageService = profileStorageService
    }
    
    // MARK: Public methods
    func retrieveCardData() {
        card = profileStorageService.loadFromStorage()
    }
    
    func saveChangesProfile() {
        guard isValidForm else {
            return
        }
        profileStorageService.saveToStore(forCards: card)
        alertItem = AlertContext.userSaveSuccess
    }
}

// MARK: - Validation
extension CardAccountViewModel {
    var isValidForm: Bool {
        guard
            card.name.isNotEmpty &&
            card.email.isNotEmpty &&
            card.phone.isNotEmpty
        else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        guard card.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        guard card.phone.isValidPhone else {
            alertItem = AlertContext.invalidForm
            return false
        }
        return true
    }
}
