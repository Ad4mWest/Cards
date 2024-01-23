//  CardListWireframe.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import SwiftUI

final class CardListWireframe {
    func makeCardList() -> AnyView {
        let fileStorageService = FileStorageServiceImpl<Card>()
        let cardStorageService = CardStorageServiceImpl(fileStorageService: fileStorageService)
        let personNetworkService = PersonNetworkServiceImpl()
        let cardListViewModel = CardListViewModel(
            personNetworkService: personNetworkService,
            cardStorageService: cardStorageService
        )
        let cardListView = CardListView(viewModel: cardListViewModel)
        return AnyView(cardListView)
    }
}


