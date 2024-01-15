//  EmptyCardView.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI

struct EmptyCardView: View {
    var body: some View {
        VStack {
            Image("emptyBlank")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Add new card")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.mainApp)
        }
    }
}

#Preview {
    EmptyCardView()
}
