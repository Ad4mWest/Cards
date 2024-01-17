//  CardInfoView.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import SwiftUI

struct CardInfoView: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.title2)
            Text(text)
                .font(.title3)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}

struct CardInfo_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(title: "age", text: "5")
    }
}
