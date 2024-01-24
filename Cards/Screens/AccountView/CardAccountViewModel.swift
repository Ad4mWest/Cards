//  CardAccountViewModel.swift
//  Cards
//  Created by Adam West on 20.01.2024.

import SwiftUI

final class CardAccountViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var card: Card = Card()
    @Published var alertItem: AlertItem?
    @Published var gender: Bool
    
    // MARK: Private properties
    private let profileStorageService: ProfileStorageService
    
    var isValidForm: Bool {
        guard !card.name.isEmpty && !card.email.isEmpty && !card.phone.isEmpty else {
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
    
    // MARK: Initialization
    init(profileStorageService: ProfileStorageService, gender: Bool = false) {
        self.profileStorageService = profileStorageService
        self.gender = gender
    }
    
    // MARK: Public methods
    func retrieveCardData() {
        card = profileStorageService.loadFromStore()
        card.gender == "Female" ? (self.gender = true) : (self.gender = false)
    }
    
    func saveChangesProfile() {
        guard isValidForm else {
            return
        }
        gender ? (card.gender = "Female") : (card.gender = "Male")
        profileStorageService.saveToStore(forCards: card)
        alertItem = AlertContext.userSaveSuccess
    }
}
