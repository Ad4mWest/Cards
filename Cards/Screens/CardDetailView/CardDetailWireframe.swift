//  CardDetailWireframe.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailWireframe {
    func makeCardDetail(card: Card, delegate: CardListViewModelDelegate) -> AnyView {
        let nameOfStorage = "Cards"
        let storageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage
        )
        let cardStorageService = CardStorageServiceImpl(fileStorageService: storageService)
        let cardDetailViewModel = CardDetailViewModel(
            card: card,
            cardStorageService: cardStorageService,
            delegate: delegate
        )
        let cardDetailView = CardDetailView(viewModel: cardDetailViewModel)
        return AnyView(cardDetailView)
    }
}

