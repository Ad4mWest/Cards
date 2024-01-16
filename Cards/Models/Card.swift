//  Card.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

struct Card: Identifiable, Decodable, Hashable {
    var id: Int
    let name: String
    let imageURL: String
    let age: Int
    let gender: String
    let nationality: String
}

struct MockData {
    static let sampleCard = Card(
        id: 001,
        name: "Adam West",
        imageURL: String(),
        age: 5,
        gender: "Male",
        nationality: "Russian")
    
    static let cards = [sampleCard, sampleCard]
}
