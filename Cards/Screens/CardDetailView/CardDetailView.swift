//  CardDetailView.swift
//  Cards
//  Created by Adam West on 12.01.2024.

import SwiftUI

struct CardDetailView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardDetailViewModel
    @State private var rotation: Double = 0
    
    // MARK: Initialization
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Lifecycle
    var body: some View {
        HStack {
            VStack(spacing: 25) {
                ZStack {
                    Divider()
                    CardRemoteImage(url: viewModel.card.imageURL)
                        .shadow(color: .mainAppC, radius: 20)
                        .rotationAnimation(rotation)
                        .onTapGesture {
                            rotation += 360
                        }
                }
                TextField("Enter your Name", text: $viewModel.card.name)
                    .font(Font.title2.weight(.bold))
                    .multilineTextAlignment(.center)
                HStack() {
                    CardDetailParametersView(
                        name: "Gender",
                        parameterString: $viewModel.card.gender
                    )
                    CardDetailParametersView(
                        name: "Age",
                        parameterInt: $viewModel.card.age
                    )
                    CardDetailParametersView(
                        name: "Nationality",
                        parameterString: $viewModel.card.nationality
                    )
                }
                VStack(alignment: .leading, spacing: 5) {
                    CardDetailPhoneMailView(
                        name: "Email",
                        value: $viewModel.card.email
                    )
                    CardDetailPhoneMailView(
                        name: "Phone",
                        value: $viewModel.card.phone
                    )
                }
                HStack() {
                    Button("Discard") {
                        viewModel.discardChanges()
                    }
                    .configurationDetailButton(
                        rotation,
                        viewModel.editingButtonsHidden
                    )
                    Spacer()
                    Button("Save") {
                        viewModel.saveCurrentCard()
                        viewModel.editingButtonsHiddens()
                    }
                    .configurationDetailButton(
                        rotation,
                        viewModel.editingButtonsHidden
                    )
                }
                Spacer()
            }
            .padding(20)
            .disabled(viewModel.editingButtonsHidden)
            .onDisappear {
                viewModel.discardChanges()
            }
            .toolbar {
                ToolbarItem(
                    placement: .primaryAction,
                    content: {
                        Button {
                            viewModel.editingButtonsHidden = false
                        } label: {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.mainAppC)
                        }
                    }
                )
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
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(
            viewModel:
                CardDetailViewModel(
                    card:
                        Card(id: UUID(),
                             name: "Adam West",
                             imageURL: "",
                             age: 5,
                             gender: "male",
                             nationality: "Ru",
                             email: "adam.west@example.com",
                             phone: "(272) 790-0888"),
                    cardStorageService:
                        CardStorageServiceImpl(
                            fileStorageService:
                                FileStorageServiceImpl(
                                    nameOfStorage: "Cards"
                                )
                        ),
                    delegate: nil
                )
        )
    }
}
