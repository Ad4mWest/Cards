//  CardStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 30.01.2024.

import XCTest
@testable import Cards

final class CardStorageServiceTests: XCTestCase {
    // MARK: Resset storage before/after each test
    override func setUp() {
        super.setUp()
        clearStorage()
        setupLogingService()
    }
    
    override func tearDown() {
        super.tearDown()
        clearStorage()
        setupLogingService()
    }
    
    // MARK: Setup loging service
    private func setupLogingService() {
        logingService.logReadCalled = false
        logingService.logWriteCalled = false
    }
    
    // MARK: Clear storage
    private func clearStorage() {
        fileStorageService.clearPersistentStorage()
    }
    
    // MARK: Mock logging service
    private var logingService = MockLoggingServiceImpl()
    
    // MARK: File storage service
    private var fileStorageService: FileStorageServiceImpl<CardContainer> {
        let nameOfStorage = "test"
        let logingService = logingService
        let fileStorageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage,
            logingService: logingService
        )
        return fileStorageService
    }
    
    // MARK: Card storage service
    private var cardStorageService: CardStorageServiceImpl {
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
    }
}
