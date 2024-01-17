//  NationalityResponse.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Foundation

struct NationalityResponse: Decodable {
    let count: Int
    let name: String
    let country: [Country]
}

struct Country: Decodable {
    let country_id: String
    let probability: Double
}

