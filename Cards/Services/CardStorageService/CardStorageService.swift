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

final class CardStorageServiceImpl: CardStorageService {
    typealias TypeData = CardContainer
    
    // MARK: Private properties
    private var fileStorageService: any FileStorageService<TypeData>
    
    // MARK: Initialization
    init(fileStorageService: any FileStorageService<TypeData>) {
        self.fileStorageService = fileStorageService
    }
    
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
    
    func deleteAllCards() {
        var container = loadContainer()
        container.cards.removeAll()
        saveToContainer(forContainer: container)
    }
}

// - MARK: Private methods
private extension CardStorageServiceImpl {
    func loadContainer() -> CardContainer {
        var container: CardContainer
        do {
            container = try fileStorageService.loadFromStore()
            return container
        } catch {
            print(APIError.invalidDecoding("Unnabled to load").localizedDescription)
            return CardContainer(cards: [])
        }
    }
    
    func saveToContainer(forContainer container: CardContainer) {
        do {
            try fileStorageService.saveToStore(forObject: container)
        } catch {
            print(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
}
