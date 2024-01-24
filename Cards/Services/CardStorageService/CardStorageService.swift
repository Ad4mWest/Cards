//  CardStorageService.swift
//  Cards
//  Created by Adam West on 23.01.2024.

import SwiftUI

protocol CardStorageService {
    func appendNewCard(forCards card: Card)
    func loadFromStorageCards() -> [Card]
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int)
    func deleteCard(atOffsets indexSet: IndexSet)
}

struct CardContainer: Codable {
    var cards: [Card]
}

final class CardStorageServiceImpl: CardStorageService, FileStorageService {
    typealias TypeData = CardContainer
    
    // MARK: Private properties
    private var container = CardContainer(cards: [])
    
    // MARK: Create
    func appendNewCard(forCards card: Card) {
        container.cards.append(card)
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
    
    // MARK: Read
    func loadFromStorageCards() -> [Card] {
        do {
            container = try loadFromStore()
            return container.cards
        } catch {
            return []
        }
    }
    
    // MARK: Edit
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        container.cards.move(fromOffsets: indices, toOffset: newOffset)
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
    
    // MARK: Delete
    func deleteCard(atOffsets indexSet: IndexSet) {
        container.cards.remove(atOffsets: indexSet)
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
}

