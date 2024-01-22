//  CardAccountViewModel.swift
//  Cards
//  Created by Adam West on 20.01.2024.

import SwiftUI

final class CardAccountViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var profileStatePackage: ProfileStatePackage<Card>
    @Published var alertItem: AlertItem?
    @Published var gender: Bool
    
    var isValidForm: Bool {
        guard !profileStatePackage.data.name.isEmpty && !profileStatePackage.data.email.isEmpty && !profileStatePackage.data.phone.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        guard profileStatePackage.data.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        guard profileStatePackage.data.phone.isValidPhone else {
            alertItem = AlertContext.invalidForm
            return false
        }
        return true
    }
    
    // MARK: Initialization
    init(cardStatePackage: ProfileStatePackage<Card>, gender: Bool = false) {
        self.profileStatePackage = cardStatePackage
        self.gender = gender
    }
    
    // MARK: Public methods
    func retrieveCardData() {
        profileStatePackage.loadFromStore()
        profileStatePackage.data.gender == "Female" ? (self.gender = true) : (self.gender = false)
    }
    
    func saveChangesProfile() {
        guard isValidForm else {
            return
        }
        gender ? (profileStatePackage.data.gender = "Female") : (profileStatePackage.data.gender = "Male")
        profileStatePackage.saveToStore()
        alertItem = AlertContext.userSaveSuccess
    }
}

//    func saveChangesProfile() {
//        guard isValidForm else {
//            return
//        }
//        do {
//            gender ? (card.gender = "Female") : (card.gender = "Male")
//            let data = try JSONEncoder().encode(card)
//            cardData = data
//            alertItem = AlertContext.userSaveSuccess
//        } catch {
//            alertItem = AlertContext.invalidUserData
//        }
//    }
    
//    func retrieveCardData() {
//        guard let cardData else {
//            return
//        }
//        do {
//            let card = try JSONDecoder().decode(Card.self, from: cardData)
//            self.card = card
//            card.gender == "Female" ? (self.gender = true) : (self.gender = false)
//
//        } catch {
//            alertItem = AlertContext.invalidUserData
//        }
//    }
