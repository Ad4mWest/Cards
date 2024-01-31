//  ProfileStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 29.01.2024.

import XCTest
@testable import Cards

final class ProfileStorageServiceTests: XCTestCase {
    // MARK: ProfileStorageService
    private func profileStorageService() -> ProfileStorageServiceImpl {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        let profileStorageService = ProfileStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        return profileStorageService
    }
    
    // MARK: SaveToStore
    func testSuccessfulSaving() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        let profileStorageService = profileStorageService()
        
        // When (Act)
        profileStorageService.saveToStore(forCards: card)
        let cardName = profileStorageService.loadFromStorage().name
        
        // Then (Assert)
        XCTAssertEqual(cardName, "Adam")
    }
    
    // MARK: LoadFromStorage
    func testSuccessfulLoadFromStorage() {
        // Given (Arrange)
        var card = Card()
        card.name = "El Guja"
        let profileStorageService = profileStorageService()
        profileStorageService.saveToStore(forCards: card)
        
        // When (Act)
        let cardStorage = profileStorageService.loadFromStorage()
        let cardName = cardStorage.name
        
        // Then (Assert)
        XCTAssertTrue(cardName == "El Guja")
    }
}
