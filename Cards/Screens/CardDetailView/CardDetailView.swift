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
                    VStack(spacing: 5) {
                        Text("Gender")
                            .bold()
                            .font(.title2)
                        TextField("Gender", text: $viewModel.card.gender)
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    VStack(spacing: 5) {
                        Text("Age")
                            .bold()
                            .font(.title2)
                        TextField(
                            "Age",
                            value: $viewModel.card.age,
                            formatter: NumberFormatter()
                        )
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    VStack(spacing: 5) {
                        Text("Nationality")
                            .bold()
                            .font(.title2)
                        TextField("Nationality", text: $viewModel.card.nationality)
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email")
                        .bold()
                        .font(.title2)
                    TextField("Email", text: $viewModel.card.email)
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("Phone")
                        .bold()
                        .font(.title2)
                    TextField("Phone", text: $viewModel.card.phone)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                HStack() {
                    Button("Discard") {
                        viewModel.discardChanges()
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.mainAppC)
                    .capsuleAnimation(rotation)
                    .hiddenConditionally(
                        viewModel.editingButtonsHidden
                    )
                    Spacer()
                    Button("Save") {
                        viewModel.saveCurrentCard()
                        viewModel.editingButtonsHiddens()
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.mainAppC)
                    .capsuleAnimation(rotation)
                    .hiddenConditionally(
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
