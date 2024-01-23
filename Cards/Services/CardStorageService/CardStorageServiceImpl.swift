//  CardStorageService.swift
//  Cards
//  Created by Adam West on 23.01.2024.

import SwiftUI

protocol CardStorageService {
    func createNewCard(forCards card: Card)
    func loadFromStorageCards() -> [Card]
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int)
    func deleteCard(atOffsets indexSet: IndexSet)
}

final class CardStorageServiceImpl: CardStorageService {
    // MARK: Public Properties
    private var cards: [Card]
    private var fileStorageService: any FileStorageService<Card>
    
    // MARK: Initialization
    init(fileStorageService: any FileStorageService<Card>) {
        self.fileStorageService = fileStorageService
        self.cards = fileStorageService.loadFromStore()
    }
    
    // MARK: Create
    func createNewCard(forCards card: Card) {
        cards.append(card)
        fileStorageService.saveToStore(toArray: cards)
    }
    
    // MARK: Read
    func loadFromStorageCards() -> [Card] {
        cards = fileStorageService.loadFromStore()
        return cards
    }
    
    // MARK: Edit
    func changePositionOfCards(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        cards.move(fromOffsets: indices, toOffset: newOffset)
        fileStorageService.saveToStore(toArray: cards)
    }
    
    // MARK: Delete
    func deleteCard(atOffsets indexSet: IndexSet) {
        cards.remove(atOffsets: indexSet)
        fileStorageService.saveToStore(toArray: cards)
    }   
}

