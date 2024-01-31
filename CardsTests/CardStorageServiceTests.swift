//  CardStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 30.01.2024.

import XCTest
@testable import Cards

final class CardStorageServiceTests: XCTestCase {
    // MARK: Resset storage after each test
    override func setUp() {
        super.setUp()
        let cardStorageService = cardStorageService()
        cardStorageService.deleteAllCards()
    }
    override func tearDown() {
        super.tearDown()
        let cardStorageService = cardStorageService()
        cardStorageService.deleteAllCards()
    }
    
    // MARK: CardStorageService
    private func cardStorageService() -> CardStorageServiceImpl {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        return cardStorageService
    }
    
    // MARK: Append new Card
    func testSuccessfulAppendNewCard() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        let cardStorageService = cardStorageService()
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let cardName = cardStorage.first?.name else {
            XCTAssertThrowsError("The storage is empty. Cannot get value.")
            return
        }
        
        // Then (Assert)
        XCTAssertEqual(cardName, "Adam")
    }
    
    // MARK: Load from storage
    func testUnsuccessfulLoadFromStorageCards() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        let cardStorageService = cardStorageService()
        cardStorageService.appendNewCard(forCards: card)
        
        // When (Act)
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let cardName = cardStorage.first?.name else {
            XCTAssertThrowsError("The storage is empty. Cannot get value.")
            return
        }

        // Then (Assert)
        XCTAssertNotEqual(cardName, "El Guja")
    }
    
    // MARK: Change card position
    func testSuccessfulChangePositionOfCards() {
        // Given (Arrange)
        var cardOne = Card()
        cardOne.age = 1
        var cardTwo = Card()
        cardTwo.age = 2
        
        let indexSet = IndexSet(integer: 1)
        let offset = 0
        
        let cardStorageService = cardStorageService()
        cardStorageService.appendNewCard(forCards: cardOne)
        cardStorageService.appendNewCard(forCards: cardTwo)
        
        // When (Act)
        cardStorageService.changePositionOfCards(fromOffsets: indexSet, toOffset: offset)
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let cardAge = cardStorage.first?.age else {
            XCTAssertThrowsError("The storage is empty. Cannot get value.")
            return
        }
        
        // Then (Assert)
        XCTAssertEqual(cardAge, 2)
    }
    
    // MARK: Delete card
    func testSuccessfulDeleteCard() {
        // Given (Arrange)
        var cardOne = Card()
        cardOne.age = 1
        var cardTwo = Card()
        cardTwo.age = 2
        let indexSet = IndexSet(integer: 1)
        
        let cardStorageService = cardStorageService()
        cardStorageService.appendNewCard(forCards: cardOne)
        cardStorageService.appendNewCard(forCards: cardTwo)
        
        // When (Act)
        cardStorageService.deleteCard(atOffsets: indexSet)
        let cardStorageCount = cardStorageService.loadFromStorageCards().count
        
        // Then (Assert)
        XCTAssertEqual(cardStorageCount, 1)
    }
    
    // MARK: Edit current card 
    func testSuccessfulEditCurrentCard() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        let cardStorageService = cardStorageService()
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        card.name = "El Guja"
        cardStorageService.editCurrentCard(forCards: card)
        
        let cardStorage = cardStorageService.loadFromStorageCards()
        guard let cardName = cardStorage.first?.name else {
            XCTAssertThrowsError("The storage is empty. Cannot get value.")
            return
        }

        // Then (Assert)
        XCTAssertEqual(cardName, "El Guja")
    }
}
