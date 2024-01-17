//  CardTabView.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import SwiftUI

struct CardTabView: View {
    private let builer = CardListWareframe()
    
    var body: some View {
        TabView {
            //CardListView()
            builer.madeCardList()
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
        .accentColor(Color.mainAppC)
    }
}

struct CardTabView_Previews: PreviewProvider {
    static var previews: some View {
        CardTabView()
    }
}
