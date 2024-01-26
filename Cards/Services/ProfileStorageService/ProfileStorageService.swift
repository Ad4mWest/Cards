//  StatePackage.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

protocol ProfileStorageService {
    func saveToStore(forCards card: Card)
    func loadFromStorage() -> Card
}

final class ProfileStorageServiceImpl: ProfileStorageService, FileStorageService  {
    typealias TypeData = Card
    
    // MARK: Save
    func saveToStore(forCards card: Card) {
        var container = loadContainer()
        container = card
        saveToContainer(forContainer: container)
    }
    
    // MARK: Read
    func loadFromStorage() -> Card {
        let container = loadContainer()
        return container
    }
}

// - MARK: Private methods
private extension ProfileStorageServiceImpl {
    private func loadContainer() -> Card {
        var container: Card
        do {
            container = try loadFromStore()
            return container
        } catch {
            print(APIError.invalidDecoding("Unnabled to load").localizedDescription)
            return Card()
        }
    }
    
    private func saveToContainer(forContainer container: Card) {
        do {
            try saveToStore(forObject: container)
        } catch {
            print(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
}
