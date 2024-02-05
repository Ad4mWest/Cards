//  CardDetailPhoneMailView.swift
//  Cards
//  Created by Adam West on 01.02.2024.

import SwiftUI

struct CardDetailPhoneMailView: View {
    // MARK: Private properties
    private var name: String
    @Binding private var value: String
    
    // MARK: Initialization
    init(name: String, value: Binding<String>) {
        self._value = value
        self.name = name
    }
    
    // MARK: Lifecycle
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(name)
                .bold()
                .font(.title2)
            TextField(name, text: $value)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct CardDetailPhoneMailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailPhoneMailView(
            name: "Adam",
            value: .constant("8 800 555 35 35")
        )
    }
}
