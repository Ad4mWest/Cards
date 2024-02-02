//  CardTabView.swift
//  Cards
//  Created by Adam West on 11.01.2024.

import SwiftUI

struct CardTabView: View {
    // MARK: Private properties
    private let cardList = CardListWireframe()
    private let cardAccount = CardAccountWireframe()
    
    // MARK: Lifecycle
    var body: some View {
        TabView {
            cardList.makeCardList()
                .tabItem {
                    Label(
                        "Cards",
                        systemImage: "lanyardcard.fill"
                    )
                }
            cardAccount.makeAccountView()
                .tabItem {
                    Label(
                        "Account",
                        systemImage: "person.text.rectangle"
                    )
                }
        }
        .accentColor(Color.mainAppC)
    }
}

struct CardTabView_Previews: PreviewProvider {
    static var previews: some View {
        CardTabView()
    }
}
