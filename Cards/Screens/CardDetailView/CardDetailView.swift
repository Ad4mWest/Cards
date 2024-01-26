//  CardDetailView.swift
//  OrderFood
//  Created by Adam West on 12.01.2024.

import SwiftUI

struct CardDetailView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardDetailViewModel
    @EnvironmentObject private var cards: Cards
    
    // MARK: Initialization
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Lifecycle
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Divider()
                CardRemoteImage(url: viewModel.card.imageURL)
                    .shadow(color: .mainAppC, radius: 20)
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
                    TextField("Age", value: $viewModel.card.age, formatter: NumberFormatter())
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
                TextField("Nationality", text: $viewModel.card.email)
                    .font(.title3)
                    .foregroundColor(.gray)
                Text("Phone")
                    .bold()
                    .font(.title2)
                TextField("Nationality", text: $viewModel.card.phone)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            HStack() {
                Button {
                    viewModel.discardChanges()
                } label: {
                    Text("Discard")
                }
                .frame(width: 100, height: 50)
                .foregroundColor(.black)
                .background(
                    Capsule()
                        .strokeBorder(
                            viewModel.angularGradient,
                            lineWidth: 3
                        )
                )
                Spacer()
                Button {
                    viewModel.editCurrentCard(
                        forCards: viewModel.card,
                        toCards: cards
                    )
                } label: {
                    Text("Save")
                }
                .frame(width: 100, height: 50)
                .foregroundColor(.black)
                .background(
                    Capsule()
                        .strokeBorder(
                            viewModel.angularGradient,
                            lineWidth: 3
                        )
                )
            }
            Spacer()
        }.padding(20)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: alertItem.dismissButton)
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
                        CardStorageServiceImpl()
                )
        )
    }
}
