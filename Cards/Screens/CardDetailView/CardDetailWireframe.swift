//  CardDetailWireframe.swift
//  Cards
//  Created by Adam West on 17.01.2024.

import SwiftUI

final class CardDetailWireframe {
    func madeCardDetail(card: Card) -> AnyView {
        let cardDetailViewModel = CardDetailViewModel(card: card)
        let cardDetailView = CardDetailView(viewModel: cardDetailViewModel)
        return AnyView(cardDetailView)
    }
}

