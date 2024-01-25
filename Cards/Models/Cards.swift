//  Cards.swift
//  Cards
//  Created by Adam West on 25.01.2024.

import Foundation

final class Cards: ObservableObject {
    @Published var cards: [Card] = []
}
