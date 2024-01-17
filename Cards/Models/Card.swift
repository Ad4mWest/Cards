//  Card.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

struct Card: Identifiable, Decodable, Hashable {
    var id: UUID
    let name: String
    let imageURL: String
    let age: Int
    let gender: String
    let nationality: String
    let email: String
    let phone: String
}
