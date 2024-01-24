//  CardAccountWireframe.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

final class CardAccountWireframe {
    func makeAccountView() -> AnyView {
        let profileStorageService = ProfileStorageServiceImpl()
        let cardAccountViewModel = CardAccountViewModel(profileStorageService: profileStorageService)
        let cardAccountView = CardAccountView(viewModel: cardAccountViewModel)
        return AnyView(cardAccountView)
    }
}
