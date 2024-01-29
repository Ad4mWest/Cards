//  CardListView.swift
//  Cards
//  Created by Adam West on 13.01.2024.

import SwiftUI
import Combine

struct CardListView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardListViewModel
    private let cardListDetail: CardDetailWireframe
    
    // MARK: Initialization
    init(viewModel: CardListViewModel) {
        self.viewModel = viewModel
        self.cardListDetail = CardDetailWireframe()
    }
    
    // MARK: Lifecycle
    var body: some View {
        NavigationView {
            ZStack {
                List() {
                    ForEach(viewModel.cards, id: \.self) { card in
                        NavigationLink {
                            cardListDetail.makeCardDetail(
                                card: card,
                                delegate: viewModel
                            )
                        } label: {
                            CardListCell(card: card)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        viewModel.onMove(fromOffsets: indices, toOffset: newOffset)
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
                if viewModel.cards.isEmpty {
                    EmptyCardView()
                }
            }
        }
        .onAppear {
            viewModel.loadFromStorage()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(
            viewModel: CardListViewModel(
                personNetworkService: PersonNetworkServiceImpl(),
                cardStorageService: CardStorageServiceImpl()
            )
        )
    }
}
