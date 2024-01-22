//  CardDetailView.swift
//  OrderFood
//  Created by Adam West on 12.01.2024.

import SwiftUI

struct CardDetailView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardDetailViewModel
    
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
            Text(viewModel.card.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {                    CardInfoView(title: "Gender",
                                 text: "\(viewModel.card.gender)")
                    CardInfoView(title: "Age",
                                 text: "\(viewModel.card.age)")
                    CardInfoView(title: "Nationality",
                                 text: "\(viewModel.card.nationality)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    CardPhoneEmailView(
                        email: viewModel.card.email,
                        phone: viewModel.card.phone)
                }
            }
            Spacer()
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
                             name: "Adam",
                             imageURL: "",
                             age: 5,
                             gender: "male",
                             nationality: "Ru",
                             email: "adam.west@example.com",
                             phone: "(272) 790-0888")))
    }
}
