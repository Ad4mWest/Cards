//  ProfileStorageServiceTests.swift
//  CardsTests
//  Created by Adam West on 29.01.2024.

import XCTest
@testable import Cards

final class ProfileStorageServiceTests: XCTestCase {
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
    private var fileStorageService: FileStorageServiceImpl<Card> {
        let nameOfStorage = "test"
        let logingService = logingService
        let fileStorageService = FileStorageServiceImpl<Card>(
            nameOfStorage: nameOfStorage,
            logingService: logingService
        )
        return fileStorageService
    }
    
    // MARK: Profile storage service
    private var profileStorageService: ProfileStorageServiceImpl {
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
        XCTAssertTrue(logingService.logReadCalled)
        XCTAssertTrue(logingService.logWriteCalled)
    }
}
