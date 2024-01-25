//  GenderResponse.swift
//  Cards
//  Created by Adam West on 18.01.2024.

import Foundation

struct GenderResponse: Decodable {
    let count: Int?
    let name: String?
    let gender: String?
    let probability: Int?
    
    init() {
        self.count = nil
        self.name = nil
        self.gender = "AGender"
        self.probability = nil
    }
}
