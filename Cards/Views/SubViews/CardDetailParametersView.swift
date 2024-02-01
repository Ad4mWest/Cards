//  CardDetailParameter.swift
//  Cards
//  Created by Adam West on 01.02.2024.

import SwiftUI

struct CardDetailParametersView: View {
    @Binding private var parameterString: String
    @Binding private var parameterInt: Int
    private let name: String
    
    init(
        name: String,
        parameterString: Binding<String> = .constant(String()),
        parameterInt: Binding<Int> = .constant(0)
    ) {
        self.name = name
        self._parameterString = parameterString
        self._parameterInt = parameterInt
    }
    
    var body: some View {
        if name == "Age" {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title2)
                TextField(name,
                          value: $parameterInt,
                          formatter: NumberFormatter()
                )
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            }
        } else {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title2)
                TextField(name, text: $parameterString)
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct CardDetailParameter_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailParametersView(
            name: "Gender",
            parameterString: .constant("RU"),
            parameterInt: .constant(0)
        )
    }
}
