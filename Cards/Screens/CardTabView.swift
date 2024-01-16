//  CardTabView.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import SwiftUI

struct CardTabView: View {
    var body: some View {
        TabView {
            CardListView()
                .tabItem {
                    Image(systemName: "lanyardcard.fill")
                    Text("Cards")
                }
            CardAccountView()
                .tabItem {
                    Image(systemName: "person.text.rectangle")
                    Text("Account")
                }
        }
        .accentColor(Color.mainApp)
    }
}

#Preview {
    CardTabView()
}
