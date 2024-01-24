//  CardDetailView.swift
//  OrderFood
//  Created by Adam West on 12.01.2024.

import SwiftUI

struct CardDetailView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardDetailViewModel
    @EnvironmentObject private var cardListModel: CardListViewModel
    
    // MARK: Initialization
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Lifecycle
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Divider()
                CardRemoteImage(url: viewModel.card.imageURL)
                    .shadow(color: .mainAppC, radius: 20)
            }
            TextField("Enter your Name", text: $viewModel.card.name)
                .font(Font.title2.weight(.bold))
                .multilineTextAlignment(.center)
            
            VStack(spacing: 10) {
                HStack(spacing: 5) {
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
                Spacer()
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
                } .padding(30)
                Spacer()
            }
        }
            .onDisappear {
                cardListModel.editCurrentCard(forCards: viewModel.card)
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
                                 phone: "(272) 790-0888")))
        }
    }
