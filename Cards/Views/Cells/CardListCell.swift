//
//  AppetizerListCell.swift
//  Appotizers
//
//  Created by Adam West on 11.01.2024.
//

import SwiftUI

struct CardListCell: View {
    var card: Card
    
    var body: some View {
        HStack(spacing: 20) {
            Image("sticker")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(card.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text(card.gender)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
        }
    }
}

#Preview {
    CardListCell(card: MockData.sampleCard)
}
