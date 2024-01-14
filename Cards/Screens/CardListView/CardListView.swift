//
//  CardListView.swift
//  Cards
//
//  Created by Adam West on 13.01.2024.
//

import SwiftUI

struct CardListView: View {
    var card = MockData.sampleCard
    @State private var cards = MockData.cards
    @State private var isShowingDetail = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(cards) { card in
                        CardListCell(card: card)
                    }
                    .onDelete(perform: { indexSet in
                        cards.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        cards.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .onTapGesture {
                        isShowingDetail = true
                    }
                }
                .disabled(isShowingDetail)
                .navigationTitle("G3n3rate 📇")
                .toolbar {
                    ToolbarItem(placement: .primaryAction,
                                content: {
                        Button {
                            cards.append(card)
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.mainApp)
                        }
                    })
                }
            }
            .blur(radius: isShowingDetail ? 20 : 0)
            
            .onAppear {

            }
            if isShowingDetail {
                CardDetailView(card: card, isShowingDetails: $isShowingDetail)
            }
            if cards.isEmpty {
                EmptyCardView()
            }
        }
    }
}

#Preview {
    CardListView()
}
