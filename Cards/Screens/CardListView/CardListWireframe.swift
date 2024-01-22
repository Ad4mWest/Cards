//  CardListWireframe.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import SwiftUI

final class CardListWireframe {
    func makeCardList() -> AnyView {
        let cardStatePackage = CardStatePackageImpl<Card>()
        let personNetworkService = PersonNetworkServiceImpl()
        let cardListViewModel = CardListViewModel(
            personNetworkService: personNetworkService,
            cardStatePackage: cardStatePackage)
        let cardListView = CardListView(viewModel: cardListViewModel)
        return AnyView(cardListView)
    }
}


