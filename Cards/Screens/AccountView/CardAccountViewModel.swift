//  CardAccountViewModel.swift
//  Cards
//  Created by Adam West on 20.01.2024.

import SwiftUI

final class CardAccountViewModel: ObservableObject {
    // MARK: Public Properties
    @ObservedObject var cardStatePackage: StatePackageImpl<Card>
    @Published var alertItem: AlertItem?
    @Published var gender: Bool
    
    var isValidForm: Bool {
        guard !cardStatePackage.data.name.isEmpty && !cardStatePackage.data.email.isEmpty && !cardStatePackage.data.phone.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        guard cardStatePackage.data.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        guard cardStatePackage.data.phone.isValidPhone else {
            alertItem = AlertContext.invalidForm
            return false
        }
        return true
    }
    
    // MARK: Initialization
    init(cardStatePackage: StatePackageImpl<Card>, gender: Bool = false) {
        self.cardStatePackage = cardStatePackage
        self.gender = gender
    }
    
    // MARK: Public methods
    func retrieveCardData() {
        cardStatePackage.loadFromStore()
        cardStatePackage.data.gender == "Female" ? (self.gender = true) : (self.gender = false)
    }
    
    func saveChangesProfile() {
        guard isValidForm else {
            return
        }
        gender ? (cardStatePackage.data.gender = "Female") : (cardStatePackage.data.gender = "Male")
        cardStatePackage.saveToStore()
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

extension CardAccountViewModel {
    static let nationality = ["AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AT", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CH", "CI", "CK", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CW", "CX", "CY", "CZ", "DE", "DJ", "DK", "DM", "DO", "DZ", "EC", "EE", "EG", "EH", "ER", "ES", "ET", "FI", "FJ", "FK", "FM", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GG", "GH", "GI", "GL", "GM", "GN", "GP", "GQ", "GR", "GS", "GT", "GU", "GW", "GY", "HK", "HM", "HN", "HR", "HT", "HU", "ID", "IE", "IL", "IM", "IN", "IO", "IQ", "IR", "IS", "IT", "JE", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NL", "NO", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL", "PM", "PN", "PR", "PS", "PT", "PW", "PY", "QA", "RE", "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SE", "SG", "SH", "SI", "SJ", "SK", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX", "SY", "SZ", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TR", "TT", "TV", "TW", "TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "YE", "YT", "ZA", "ZM", "ZW"]
}
