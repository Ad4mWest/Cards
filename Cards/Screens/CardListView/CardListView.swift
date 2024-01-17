//  CardListView.swift
//  Cards
//  Created by Adam West on 13.01.2024.

import SwiftUI
import Combine

struct CardListView: View {
    //@StateObject var viewModel = CardListViewModel(apiClient: PersonNetworkServiceImpl())
    
    @StateObject private var viewModel: CardListViewModel
    
    init(viewModel: CardListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.cards, id: \.self) { card in
                        CardListCell(card: card)
                            .onTapGesture {
                                viewModel.isShowingDetail = true
                                viewModel.selectedCard = card
                            }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.cards.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        viewModel.cards.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    
                }
                .disabled(viewModel.isShowingDetail)
                .navigationTitle("Generate cards")
                .toolbar {
                    ToolbarItem(placement: .primaryAction,
                                content: {
                        Button {
                            viewModel.getNewCard()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.mainAppC)
                        }
                    })
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                if let selectedCard = viewModel.selectedCard {
                    CardDetailView(card: selectedCard, isShowingDetails: $viewModel.isShowingDetail)
                }
            }
            
            if viewModel.cards.isEmpty {
                EmptyCardView()
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(viewModel: CardListViewModel(apiClient: PersonNetworkServiceImpl()))
    }
}
