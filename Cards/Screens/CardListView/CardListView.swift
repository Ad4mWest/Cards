//  CardListView.swift
//  Cards
//  Created by Adam West on 13.01.2024.

import SwiftUI
import Combine

struct CardListView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardListViewModel
    
    private let cardDetail = CardDetailWireframe()
    
    // MARK: Initialization
    init(viewModel: CardListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Lifecycle
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.cards, id: \.self) { card in
                        CardListCell(card: card)
                        NavigationLink("Details") {
                            cardDetail.madeCardDetail(card: card)
                        } 
                        .foregroundColor(.mainApp)
                        .font(.title3)
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.cards.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        viewModel.cards.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    
                }
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
