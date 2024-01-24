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
    
    // MARK: Private properties
    private var container = ProfileContainer(profile: Card())
    
    // MARK: Save
    func saveToStore(forCards card: Card) {
        container.profile = card
        do {
            try saveToStore(forObject: container)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to save").localizedDescription)
        }
    }
    
    // MARK: Read
    func loadFromStore() -> Card {
        do {
            container = try loadFromStore()
            return container.profile
        } catch {
            return Card()
        }
    }
}
