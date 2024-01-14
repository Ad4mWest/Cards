//
//  CardDetailView.swift
//  OrderFood
//
//  Created by Adam West on 12.01.2024.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    @Binding var isShowingDetails: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image("sticker")
                .resizable()
                .frame(width: 300, height: 225)
            VStack(spacing: 20) {
                Text(card.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(spacing: 40) {
                    CardInfo(title: "Age",
                             text: "\(card.age)")
                    CardInfo(title: "Gender",
                                  text: "\(card.gender)")
                    CardInfo(title: "Nationality",
                             text: "\(card.nationality)")
                }
            }
            Spacer()
        }
        .frame(width: 300, height: 375)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        
        .overlay(alignment: .topTrailing) {
            Button {
                isShowingDetails = false
            } label: {
                XDismissButton()
            }
        }
    }
}

#Preview {
    CardDetailView(card: MockData.sampleCard, isShowingDetails: .constant(true))
}

struct CardInfo: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            Text(text)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
