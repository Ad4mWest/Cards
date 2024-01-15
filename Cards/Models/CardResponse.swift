//  CardResponse.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import Foundation

struct CardResponse: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let name: Person
    let picture: Picture
}

struct Person: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
