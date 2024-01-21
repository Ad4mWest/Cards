//  Card.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

struct Card: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var imageURL: String
    var age: Int
    var gender: String
    var nationality: String
    var email: String
    var phone: String
}

extension Card {
    init() {
        self.id = UUID()
        self.name = String()
        self.imageURL = String()
        self.age = Int()
        self.gender = String()
        self.nationality = String()
        self.email = String()
        self.phone = String()
    }
}
