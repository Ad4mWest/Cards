//  AppetizerListCell.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import SwiftUI

struct CardListCell: View {
    var card: Card
    
    var body: some View {
        HStack(spacing: 20)
        {
            AsyncImageView(url: card.imageURL)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(card.name)
                    .font(.title2)
                    .fontWeight(.medium)
                if #available(iOS 16.0, *) {
                    Text(card.gender)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                } else {
                    Text(card.gender)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
            }
            .padding(.leading)
        }
    }
}

struct CardListCell_Previews: PreviewProvider {
    static var previews: some View {
        CardListCell(card: Card(
            id: 001,
            name: "Adam",
            imageURL: "",
            age: 5,
            gender: "male",
            nationality: "Ru"))
    }
}
