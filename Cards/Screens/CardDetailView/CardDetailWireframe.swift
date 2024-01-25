//  CardDetailWireframe.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailWireframe {
    func makeCardDetail(card: Card) -> AnyView {
        let cardStorageService = CardStorageServiceImpl()
        let cardDetailViewModel = CardDetailViewModel(
            card: card,
            cardStorageService: cardStorageService
        )
        let cardDetailView = CardDetailView(viewModel: cardDetailViewModel)
        return AnyView(cardDetailView)
    }
}

