//  CardStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 30.01.2024.

import XCTest
@testable import Cards

final class CardStorageServiceTests: XCTestCase {
    // MARK: Resset storage after each test
    override func setUp() {
        super.setUp()
        clearStorage()
    }
    
    override func tearDown() {
        super.tearDown()
        clearStorage()
    }
    
    // MARK: Clear storage
    private func clearStorage() {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(nameOfStorage: nameOfStorage)
        fileStorageService.clearPersistentStorage()
    }
    
    // MARK: Profile storage service
    private var cardStorageService: CardStorageServiceImpl {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<CardContainer>(nameOfStorage: nameOfStorage)
        let profileStorageService = CardStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        return profileStorageService
    }
    
    // MARK: Append new Card
    func testSuccessfulAppendNewCard() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        
        // When (Act)
        cardStorageService.appendNewCard(forCards: card)
        let cardStorage = cardStorageService.loadFromStorageCards()

        // Then (Assert)
        XCTAssertEqual(cardStorage.first?.name, "Adam")
    }
    
    // MARK: Load from storage
    func testUnsuccessfulLoadFromStorageCards() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        cardStorageService.appendNewCard(forCards: card)
        
        // When (Act)
        let cardStorage = cardStorageService.loadFromStorageCards()

        // Then (Assert)
        XCTAssertNotEqual(cardStorage.first?.name, "El Guja")
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
        
        cardStorageService.appendNewCard(forCards: cardOne)
        cardStorageService.appendNewCard(forCards: cardTwo)
        
        // When (Act)
        cardStorageService.changePositionOfCards(fromOffsets: indexSet, toOffset: offset)
        let cardStorage = cardStorageService.loadFromStorageCards()
        
        // Then (Assert)
        XCTAssertEqual(cardStorage[0].age, 2)
        XCTAssertEqual(cardStorage[1].age, 1)
    }
    
    // MARK: Delete card
    func testSuccessfulDeleteCard() {
        // Given (Arrange)
        var cardOne = Card()
        cardOne.age = 1
        var cardTwo = Card()
        cardTwo.age = 2
        let indexSet = IndexSet(integer: 1)
        
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
        cardStorageService.appendNewCard(forCards: card)
        
        // When (Act)
        card.name = "El Guja"
        cardStorageService.editCurrentCard(forCards: card)
        let cardStorage = cardStorageService.loadFromStorageCards()

        // Then (Assert)
        XCTAssertEqual(cardStorage.first?.name, "El Guja")
    }
}
