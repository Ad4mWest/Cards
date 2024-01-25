//  NationalityResponse.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Foundation

struct NationalityResponse: Decodable {
    let count: Int
    let name: String
    let country: [Country]
    
    struct Country: Decodable {
        enum CodingKeys: String, CodingKey {
            case countryId = "country_id"
            case probability
        }
        let countryId: String
        let probability: Double
    }
    
    init() {
        self.count = 0
        self.name = String()
        self.country = [
            Country(
            countryId: "RU",
            probability: 0
            )
        ]
    }
}



