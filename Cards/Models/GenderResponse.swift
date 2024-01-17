//  GenderResponse.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Foundation

struct GenderResponse: Decodable {
    let count: Int
    let name: String
    let gender: String
    let probability: Int
}
