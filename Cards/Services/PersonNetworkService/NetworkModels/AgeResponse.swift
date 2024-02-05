//  AgeResponse.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Foundation

struct AgeResponse: Decodable {
    let count: Int
    let name: String
    let age: Int
}

extension AgeResponse {
    init() {
        self.count = 0
        self.name = String()
        self.age = 33
    }
}


