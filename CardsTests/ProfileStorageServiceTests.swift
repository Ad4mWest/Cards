//  ProfileStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 29.01.2024.

import XCTest
@testable import Cards

final class ProfileStorageServiceTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        clearStorage()
    }
    
    // MARK: Clear storage
    private func clearStorage() {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        fileStorageService.clearPersistentStorage()
    }
    
    // MARK: Profile storage service
    private var profileStorageService: ProfileStorageServiceImpl {
        let nameOfStorage = "test"
        let fileStorageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        let profileStorageService = ProfileStorageServiceImpl(
            fileStorageService: fileStorageService
        )
        return profileStorageService
    }
        
    // MARK: Save to store
    func testSuccessfulSaving() {
        // Given (Arrange)
        var card = Card()
        card.name = "Adam"
        
        // When (Act)
        profileStorageService.saveToStore(forCards: card)
        let cardStorage = profileStorageService.loadFromStorage()
        
        // Then (Assert)
        XCTAssertEqual(cardStorage.name, "Adam")
        XCTAssertNotEqual(cardStorage.name, "El Guja")
    }
}
