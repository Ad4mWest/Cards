//  CardAccountWireframe.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

final class CardAccountWireframe {
    func makeAccountView() -> AnyView {
        let card = Card()
        let statePackageImpl = StatePackageImpl(data: card)
        let cardAccountViewModel = CardAccountViewModel(cardStatePackage: statePackageImpl)
        let cardAccountView = CardAccountView(viewModel: cardAccountViewModel)
        return AnyView(cardAccountView)
    }
}
