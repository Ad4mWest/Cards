//  CardListWireframe.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import SwiftUI

final class CardListWireframe {
    func makeCardList() -> AnyView {
        let nameOfStorage = CardStorageServiceImpl.nameOfStorage
        let logingService = LoggingServiceImpl()
        let storageService = FileStorageServiceImpl<CardContainer>(
            nameOfStorage: nameOfStorage, 
            logingService: LoggingServiceImpl()
        )
        let cardStorageService = CardStorageServiceImpl(fileStorageService: storageService)
        let personNetworkService = PersonNetworkServiceImpl()
        let cardListViewModel = CardListViewModel(
            personNetworkService: personNetworkService,
            cardStorageService: cardStorageService
        )
        let cardListView = CardListView(viewModel: cardListViewModel)
        return AnyView(cardListView)
    }
}


