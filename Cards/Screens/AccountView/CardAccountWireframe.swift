//  CardAccountWireframe.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

final class CardAccountWireframe {
    func makeAccountView() -> AnyView {
        let nameOfStorage = "Profile"
        let storageService = FileStorageServiceImpl<Card>(nameOfStorage: nameOfStorage)
        let profileStorageService = ProfileStorageServiceImpl(
            fileStorageService: storageService
        )
        let cardAccountViewModel = CardAccountViewModel(profileStorageService: profileStorageService)
        let cardAccountView = CardAccountView(viewModel: cardAccountViewModel)
        return AnyView(cardAccountView)
    }
}
