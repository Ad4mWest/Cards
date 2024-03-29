//  CardDetailWireframe.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailWireframe {
    func makeCardDetail(card: Card, delegate: CardListViewModelDelegate) -> AnyView {
        let nameOfStorage = CardStorageServiceImpl.nameOfStorage
        let logingService = LoggingServiceImpl()
        let storageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage, 
            logingService: logingService
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

