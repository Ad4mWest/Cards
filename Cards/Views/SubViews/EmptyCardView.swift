//  EmptyCardView.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI

struct EmptyCardView: View {
    var body: some View {
       VStack {
            Image("emptyCard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
        }
    }
}

#Preview {
    EmptyCardView()
}
