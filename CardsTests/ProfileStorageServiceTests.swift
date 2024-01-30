//  ProfileStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 29.01.2024.

import XCTest
@testable import Cards

final class ProfileStorageServiceTests: XCTestCase {
    func testSuccessfulSaving() {
        // Given (Arrange)
        let card = Card()
        let nameOfStorage = "testSuccessfulSaving"
        let fileStorageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        let profileStorageService = ProfileStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        profileStorageService.saveToStore(forCards: card)
        let savingCard = profileStorageService.loadFromStorage()
        
        // Then (Assert)
        XCTAssertEqual(card, savingCard)
    }
    
    func testUnsuccessfulSaving() {
        // Given (Arrange)
        var card = Card(
            id: UUID(),
            name: String(),
            imageURL: String(),
            age: 1,
            gender: String(),
            nationality: String(),
            email: String(),
            phone: String()
        )
        let nameOfStorage = "testUnsuccessfulSaving"
        let fileStorageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        let profileStorageService = ProfileStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        
        // When (Act)
        profileStorageService.saveToStore(forCards: card)
        card.age = 2
        let savingCard = profileStorageService.loadFromStorage()
        
        // Then (Assert)
        XCTAssertNotEqual(card, savingCard)
    }
}
