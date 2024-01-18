//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import Foundation

final class CardDetailViewModel: ObservableObject {
    @Published var card: Card
    
    init(card: Card) {
        self.card = card
    }
}
