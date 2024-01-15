//  CardInfo.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import SwiftUI

struct CardInfo: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            Text(text)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}

#Preview {
    CardInfo(title: String(), text: String())
}
