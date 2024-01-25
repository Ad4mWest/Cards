//  StatePackage.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

protocol ProfileStorageService {
    func saveToStore(forCards card: Card)
    func loadFromStore() -> Card
}

struct ProfileContainer: Codable {
    var profile: Card
}

final class ProfileStorageServiceImpl: ProfileStorageService, FileStorageService  {
    typealias TypeData = ProfileContainer
    
    // MARK: Save
    func saveToStore(forCards card: Card) {
        var container = loadContainer()
        container.profile = card
        saveToContainer(forContainer: container)
    }
    
    // MARK: Read
    func loadFromStore() -> Card {
        let container = loadContainer()
        return container.profile
    }
}
 
// - MARK: Private methods
private extension ProfileStorageServiceImpl {
    private func loadContainer() -> ProfileContainer {
        var container: ProfileContainer
        do {
            container = try loadFromStore()
            return container
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to load").localizedDescription)
            return ProfileContainer(profile: Card())
        }
    }
    
    private func saveToContainer(forContainer container: ProfileContainer) {
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
}
