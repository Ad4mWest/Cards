//  CardStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 30.01.2024.

import XCTest
@testable import Cards

final class CardStorageServiceTests: XCTestCase {
    func testSuccessfulAppendNewCard() {
        // Given (Arrange)
        let card = Card()
        let nameOfStorage = "testSuccessfulAppendNewCard"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let newCard = cardStorage.first else {
            return
        }
        cardStorageService.deleteCard(atOffsets: IndexSet(0...cardStorage.count))
        // Then (Assert)
        XCTAssertEqual(card, newCard)
    }
    
    func testUnsuccessfulLoadFromStorageCards() {
        // Given (Arrange)
        var card = Card()
        let nameOfStorage = "testUnsuccessfulLoadFromStorageCards"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        card.age = 1
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let newCard = cardStorage.first else {
            return
        }
        cardStorageService.deleteCard(atOffsets: IndexSet(0...cardStorage.count))
        // Then (Assert)
        XCTAssertNotEqual(card, newCard)
    }
    
    func testSuccessfulChangePositionOfCards() {
        // Given (Arrange)
        var cardOne = Card()
        cardOne.age = 1
        var cardTwo = Card()
        cardTwo.age = 2
        var cards = [cardOne, cardTwo]
        
        let indexSet = IndexSet(integer: 1)
        let offset = 0
        
        let nameOfStorage = "testSuccessfulChangePositionOfCards"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: cardOne)
        cardStorageService.appendNewCard(forCards: cardTwo)
        
        cards.move(fromOffsets: indexSet, toOffset: offset)
        cardStorageService.changePositionOfCards(fromOffsets: indexSet, toOffset: offset)
        
        let cardStorage = cardStorageService.loadFromStorageCards()
        cardStorageService.deleteCard(atOffsets: IndexSet(0...cardStorage.count))
        // Then (Assert)
        XCTAssertEqual(cards, cardStorage)
    }
    
    func testSuccessfulDeleteCard() {
        // Given (Arrange)
        let card = Card()
        var cards = [card]
        let indexSet = IndexSet(integer: 1)
        
        let nameOfStorage = "testSuccessfulDeleteCard"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        cardStorageService.appendNewCard(forCards: card)
        
        // When (Act)
        cards.remove(atOffsets: indexSet)
        cardStorageService.deleteCard(atOffsets: indexSet)
        
        let cardStorage = cardStorageService.loadFromStorageCards()
        cardStorageService.deleteCard(atOffsets: IndexSet(0...cardStorage.count))
        // Then (Assert)
        XCTAssertEqual(cards, cardStorage)
    }
    
    func testSuccessfuleditCurrentCard() {
        // Given (Arrange)
        var card = Card()
        
        let nameOfStorage = "testSuccessfuleditCurrentCard"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        card.age = 1
        cardStorageService.editCurrentCard(forCards: card)
        
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let newCard = cardStorage.first else {
            return
        }
        cardStorageService.deleteCard(atOffsets: IndexSet(0...cardStorage.count))
        
        // Then (Assert)
        XCTAssertEqual(card, newCard)
    }
}
