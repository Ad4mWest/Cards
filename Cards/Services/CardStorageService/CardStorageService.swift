//  CardStorageService.swift
//  Cards
//  Created by Adam West on 23.01.2024.

import SwiftUI

protocol CardStorageService {
    func appendNewCard(forCards card: Card)
    func loadFromStorageCards() -> [Card]
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int)
    func deleteCard(atOffsets indexSet: IndexSet)
    func editCurrentCard(forCards card: Card)
}

struct CardContainer: Codable {
    var cards: [Card]
}

final class CardStorageServiceImpl: CardStorageService, FileStorageService {
    typealias TypeData = CardContainer

    // MARK: Create
    func appendNewCard(forCards card: Card) {
        var container = loadContainer()
        container.cards.append(card)
        saveToContainer(forContainer: container)
    }
    
    // MARK: Read
    func loadFromStorageCards() -> [Card] {
        let container = loadContainer()
        return container.cards
    }
    
    // MARK: Edit
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        var container = loadContainer()
        container.cards.move(fromOffsets: indices, toOffset: newOffset)
        saveToContainer(forContainer: container)
    }
    
    func editCurrentCard(forCards card: Card) {
        var container = loadContainer()
        if let row = container.cards.firstIndex(where: {$0.id == card.id}) {
            container.cards[row] = card
        }
        saveToContainer(forContainer: container)
    }
    
    // MARK: Delete
    func deleteCard(atOffsets indexSet: IndexSet) {
        var container = loadContainer()
        container.cards.remove(atOffsets: indexSet)
        saveToContainer(forContainer: container)
    }
}

// - MARK: Private methods
private extension CardStorageServiceImpl {
    func loadContainer() -> CardContainer {
        var container: CardContainer
        do {
            container = try loadFromStore()
            return container
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to load").localizedDescription)
            return CardContainer(cards: [])
        }
    }
    
    func saveToContainer(forContainer container: CardContainer) {
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
}
