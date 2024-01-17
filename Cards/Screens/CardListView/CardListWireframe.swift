//  CardListWireframe.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import SwiftUI

final class CardListWireframe {
    func madeCardList() -> AnyView {
        let apiClient = PersonNetworkServiceImpl()
        let cardListViewModel = CardListViewModel(apiClient: apiClient)
        let cardListView = CardListView(viewModel: cardListViewModel)
        return AnyView(cardListView)
    }
}


