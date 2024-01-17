//  PersonResponse.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import Foundation

struct PersonResponse: Decodable {
    let results: [Person]
}

struct Person: Decodable {
    let gender: String
    let name: PersonName
    let email: String
    let phone: String
    let picture: PersonPicture
}

struct PersonName: Decodable {
    let title: String
    let first: String
    let last: String
}

struct PersonPicture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
