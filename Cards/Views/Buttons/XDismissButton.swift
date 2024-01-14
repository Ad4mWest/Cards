//
//  XDismissButton.swift
//  OrderFood
//
//  Created by Adam West on 13.01.2024.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .opacity(0.6)
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundStyle(.black)
                .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    XDismissButton()
}
