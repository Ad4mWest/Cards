//  CardDetailViewModel.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import Foundation

final class CardDetailViewModel: ObservableObject {
    // MARK: Public Properties
    @Published var card: Card
    
    // MARK: Initialization
    init(card: Card) {
        self.card = card
    }
}
